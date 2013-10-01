note
	description	: "Summary description for {ABOUT_QUIT}."
	author		: "Justine Compagnon"
	date		: "Date"
	revision	: "Revision"

class
	ABOUT_QUIT

inherit
	EV_DIALOG
		redefine
			initialize
		end

	INTERFACE_NAMES
		export
			{NONE} all
		undefine
			default_create, copy
		end

create
	default_create

feature {NONE} -- Initialization

	initialize
			-- Populate the dialog box.
		local
			main_horizontal_box: EV_HORIZONTAL_BOX
			left_vertical_box: EV_VERTICAL_BOX
			right_vertical_box: EV_VERTICAL_BOX
			horizontal_separator: EV_HORIZONTAL_SEPARATOR
			buttons_box: EV_HORIZONTAL_BOX
			ev_cell: EV_CELL
		do
			Precursor

				--| Add the pixmap to the dialog box.
				--|
				--| We do not use `{EV_STOCK_PIXMAPS}.Information_pixmap'
				--| directly because a given pixmap can only have one
				--| parent. `Information_pixmap' may have alredy been put
				--| into another container.
			create pixmap
			pixmap.copy ((create {EV_STOCK_PIXMAPS}).Information_pixmap)
			pixmap.set_minimum_size (pixmap.width, pixmap.height)

			create message_label
			message_label.align_text_left

			create horizontal_separator

			create ok_button.make_with_text (Button_ok_item)
			ok_button.set_minimum_size (75, 24)

			ok_button.select_actions.extend (agent destroy)

			create cancel_button.make_with_text (Button_cancel_item)
			cancel_button.set_minimum_size (75, 24)
			cancel_button.select_actions.extend (agent destroy)

			create buttons_box
			buttons_box.extend (create {EV_CELL}) -- Fill in empty space on left
			buttons_box.extend (ok_button)
			buttons_box.disable_item_expand (ok_button)
			buttons_box.extend (cancel_button)
			buttons_box.disable_item_expand (cancel_button)


			create left_vertical_box
			left_vertical_box.set_border_width (7)
			left_vertical_box.extend (pixmap)
			left_vertical_box.disable_item_expand (pixmap)
			left_vertical_box.extend (create {EV_CELL})

			create right_vertical_box
			right_vertical_box.set_padding (7)
			right_vertical_box.extend (message_label)
			right_vertical_box.extend (horizontal_separator)
			right_vertical_box.disable_item_expand (horizontal_separator)
			right_vertical_box.extend (buttons_box)
			right_vertical_box.disable_item_expand (buttons_box)

			create main_horizontal_box
			main_horizontal_box.set_border_width (7)
			create ev_cell
			ev_cell.set_minimum_width (21)
			main_horizontal_box.extend (ev_cell)
			main_horizontal_box.disable_item_expand (ev_cell)
			main_horizontal_box.extend (left_vertical_box)
			main_horizontal_box.disable_item_expand (left_vertical_box)
			create ev_cell
			ev_cell.set_minimum_width (28)
			main_horizontal_box.extend (ev_cell)
			main_horizontal_box.disable_item_expand (ev_cell)
			main_horizontal_box.extend (right_vertical_box)
			extend (main_horizontal_box)

			set_default_push_button (ok_button)
			set_default_cancel_button (cancel_button)

			set_title (Default_title)
			set_message (Default_message)
			set_size (400, 150)
		end

feature -- Add actions

		-- /!\ new to be added straight after init! If not added, it won't close the window
		add_close_action(window_to_close : ABSTRACT_MAIN_WINDOW)
		do
			ok_button.select_actions.extend (agent window_to_close.request_close_window)
		end

feature -- Access

	message: STRING
			-- Message displayed in the dialog box.
		do
			Result := message_label.text
		end

feature -- Element change

	set_message (a_message: STRING)
		do
			message_label.set_text (a_message)
		end

feature {NONE} -- Implementation

	message_label: EV_LABEL
			-- Label situated on the top of the dialog,
			-- contains the message.

	pixmap: EV_PIXMAP
			-- Pixmap display on the left of the dialog.

	ok_button: EV_BUTTON
			-- "OK" button.

	cancel_button: EV_BUTTON
			--"Cancel" button

feature {NONE} -- Implementation / Constants

	Default_title: STRING = "About Quit"
			-- Default title for the dialog window.

	Default_message: STRING
	do Result := Label_confirm_close_window
	 end

	gui: MAIN_WINDOW


end -- class ABOUT_DIALOG
