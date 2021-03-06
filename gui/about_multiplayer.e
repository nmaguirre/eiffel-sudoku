note
	description: "Summary description for {ABOUT_MULTIPLAYER}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	ABOUT_MULTIPLAYER
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
			right_vertical_box: EV_VERTICAL_BOX
			buttons_box: EV_HORIZONTAL_BOX
			ev_cell: EV_CELL
		do
			Precursor

			create message_label
			message_label.align_text_left

			create server_button.make_with_text ("Server")
			server_button.set_minimum_size (75, 75)
			server_button.select_actions.extend (agent request_about_server)


			create client_button.make_with_text ("Client")
			client_button.set_minimum_size (75, 75)
			client_button.select_actions.extend (agent request_about_client)

			create cancel_button.make_with_text (Button_cancel_item)
			cancel_button.set_minimum_size (75, 75)
			cancel_button.select_actions.extend (agent close_multiplayer_on_cancel())

			create buttons_box
			buttons_box.extend (create {EV_CELL}) -- Fill in empty space on left
			buttons_box.extend (client_button)
			buttons_box.disable_item_expand (client_button)
			buttons_box.extend (server_button)
			buttons_box.disable_item_expand (server_button)
			buttons_box.extend (cancel_button)
			buttons_box.disable_item_expand (cancel_button)

			create right_vertical_box
			right_vertical_box.set_padding (7)
			right_vertical_box.extend (buttons_box)
			right_vertical_box.disable_item_expand (buttons_box)

			create main_horizontal_box
			main_horizontal_box.set_border_width (7)
			create ev_cell
			ev_cell.set_minimum_width (40)
			main_horizontal_box.extend (ev_cell)
			main_horizontal_box.disable_item_expand (ev_cell)
			main_horizontal_box.extend (right_vertical_box)
			extend (main_horizontal_box)

			set_default_push_button (server_button)
			set_default_push_button (client_button)
			set_default_cancel_button (cancel_button)

			set_title (Default_title)
			set_size (250, 100)
		end

feature
		set_controller(crt:SUDOKU_CONTROLLER)
		require
			crt /= void
		do
			controller:=crt
		end

feature
		set_multiplayer_window(window:MULTIPLAYER_WINDOW)
		require
			window /= void
		do
			multiplayer_window:=window
		end

feature
	close_multiplayer_on_cancel()
	do
		current.destroy
		multiplayer_window.destroy
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

	client_button: EV_BUTTON
			-- "client" button.

	server_button: EV_BUTTON
			--"server" button

	cancel_button: EV_BUTTON
			--"cancel" button

feature {NONE}
	request_about_server
	local
		local_server_level:ABOUT_LOCAL_SERVER_LEVEL
	do
		create local_server_level
		local_server_level.set_controller (controller)
		local_server_level.show
		current.destroy
	end

feature {NONE}
	request_about_client
	local
		external_server:ABOUT_IP_EXTERNAL
	do
		create external_server
		external_server.set_controller(controller)
		external_server.show
		current.destroy
	end


feature {NONE} -- Implementation / Constants

	Default_title: STRING = "What do you want to be?"
			-- Default title for the dialog window.

	gui: MAIN_WINDOW

	controller:SUDOKU_CONTROLLER

	multiplayer_window:MULTIPLAYER_WINDOW
		--multiplayer window

end -- class ABOUT_NEW
