Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A647B600815
	for <lists+linux-hyperv@lfdr.de>; Mon, 17 Oct 2022 09:51:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229977AbiJQHvf (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 17 Oct 2022 03:51:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229663AbiJQHve (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 17 Oct 2022 03:51:34 -0400
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7C6CAE43;
        Mon, 17 Oct 2022 00:51:31 -0700 (PDT)
Received: by mail-pg1-x532.google.com with SMTP id q9so9749636pgq.8;
        Mon, 17 Oct 2022 00:51:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fSRrdzVHidQmdaT3eWjePmJqgOjvcCUYpgRIpnaOzjk=;
        b=eBHLP+PHw8gAJVBUUXK+CVjZYlQQRyFkUO+0b5pdPcT57o4NFWkDAqgKyM8eBreZeF
         dlwz60eL+1cmFVCeae7RQgPbhKMNA7UqWWd0JnfKp3kr2cFg5xsYyu3CwIRFkQjcPscV
         yhv9cG57GYZP4OJHVQ8YAzWmssGkq6HscDYXvuzd9l8/NfMbBpnRzyh0WWnG9WshyFWH
         t5wT4eAXIKGXNC7lM/l9V4AT/bQTVobyBJxd7gSijqoFBo75d/ylLtuQmyyRPfSIryoN
         +SuU7iQfA6p8aCEXiaC4uyGS2VCyDtyVNC6AbYPbhwl/rIAJ6lwchZfFHOWVwnp6qr4Q
         5gvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fSRrdzVHidQmdaT3eWjePmJqgOjvcCUYpgRIpnaOzjk=;
        b=UOAE3lWAePD7DyfK8+AyX4+6+G0TGlvBM9oPuhVSddYfMI9vwf69O5JlX+RLVAxuEV
         fwrAPOPdlmQ6u4FbSlI/ANB58JHg2DI/lGJ+1EGgWR2xil0iO1hj41Uyk46qAD3FlDjV
         pw6TYqqD2zwSqMe+l594ChF/GdAGmRZyZEBM1y3dHKA6CQqCACrC7RCBFDEoVU/RzUwM
         HEWqU4whCFea0o/LT1LLIumscny8FYqnZ0KJeQIrLlzZrSHlB8sYHNqZJG+i+kPWEpIv
         +ZOqdSYeB04sNMRNQYyIwmEpKK/4EGuhOe36vo0AKp6CnfRco5oOjvyVOYn5Mmp2OP4v
         GAyQ==
X-Gm-Message-State: ACrzQf266LlQasMxZOAIXTe3Bg8crWV2pN6VenLSRAqKRCtJUmihHVUy
        XuqDfKKmoBK3SDI+pxTkVihcQdqusorKTA==
X-Google-Smtp-Source: AMsMyM6v6UgwrK4uhQfJu77rGrSV5hWVReBIwXht6R+lD4KEUKOMCjjye8N1ga0JqUJqHeLoxnUhJw==
X-Received: by 2002:a05:6a00:134f:b0:563:7aa8:5cea with SMTP id k15-20020a056a00134f00b005637aa85ceamr11107925pfu.69.1665993091229;
        Mon, 17 Oct 2022 00:51:31 -0700 (PDT)
Received: from mail.google.com (122-58-209-93-fibre.sparkbb.co.nz. [122.58.209.93])
        by smtp.gmail.com with ESMTPSA id x89-20020a17090a6c6200b0020d43c5c9a0sm5576400pjj.18.2022.10.17.00.51.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Oct 2022 00:51:30 -0700 (PDT)
Date:   Mon, 17 Oct 2022 20:51:22 +1300
From:   Paulo Miguel Almeida <paulo.miguel.almeida.rodenas@gmail.com>
To:     "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
        Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        linux-hyperv@vger.kernel.org, linux-input@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
        paulo.miguel.almeida.rodenas@gmail.com
Subject: [PATCH] [next] HID: hyperv: Replace one-element array with
 flexible-array member
Message-ID: <Y00JenqCzKRrcTiF@mail.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

One-element arrays are deprecated, and we are replacing them with
flexible array members instead. So, replace one-element array with
flexible-array member in structs synthhid_msg, synthhid_input_report,
pipe_prt_msg and refactor the rest of the code accordingly.

This helps with the ongoing efforts to tighten the FORTIFY_SOURCE
routines on memcpy() and help us make progress towards globally
enabling -fstrict-flex-arrays=3 [1].

Link: https://github.com/KSPP/linux/issues/79
Link: https://github.com/KSPP/linux/issues/210
Link: https://gcc.gnu.org/bugzilla/show_bug.cgi?id=101836 [1]

Signed-off-by: Paulo Miguel Almeida <paulo.miguel.almeida.rodenas@gmail.com>
---
 drivers/hid/hid-hyperv.c | 17 +++++++----------
 1 file changed, 7 insertions(+), 10 deletions(-)

diff --git a/drivers/hid/hid-hyperv.c b/drivers/hid/hid-hyperv.c
index e0bc73124196..208cf8d981a5 100644
--- a/drivers/hid/hid-hyperv.c
+++ b/drivers/hid/hid-hyperv.c
@@ -61,7 +61,7 @@ struct synthhid_msg_hdr {
 
 struct synthhid_msg {
 	struct synthhid_msg_hdr header;
-	char data[1]; /* Enclosed message */
+	char data[]; /* Enclosed message */
 };
 
 union synthhid_version {
@@ -99,7 +99,7 @@ struct synthhid_device_info_ack {
 
 struct synthhid_input_report {
 	struct synthhid_msg_hdr header;
-	char buffer[1];
+	char buffer[];
 };
 
 #pragma pack(pop)
@@ -118,7 +118,7 @@ enum pipe_prot_msg_type {
 struct pipe_prt_msg {
 	enum pipe_prot_msg_type type;
 	u32 size;
-	char data[1];
+	char data[];
 };
 
 struct  mousevsc_prt_msg {
@@ -232,7 +232,7 @@ static void mousevsc_on_receive_device_info(struct mousevsc_dev *input_device,
 
 	ret = vmbus_sendpacket(input_device->device->channel,
 			&ack,
-			sizeof(struct pipe_prt_msg) - sizeof(unsigned char) +
+			sizeof(struct pipe_prt_msg) +
 			sizeof(struct synthhid_device_info_ack),
 			(unsigned long)&ack,
 			VM_PKT_DATA_INBAND,
@@ -271,16 +271,14 @@ static void mousevsc_on_receive(struct hv_device *device,
 		 * malicious/buggy hypervisor/host, add a check here to
 		 * ensure we don't corrupt memory.
 		 */
-		if ((pipe_msg->size + sizeof(struct pipe_prt_msg)
-			- sizeof(unsigned char))
+		if (struct_size(pipe_msg, data, pipe_msg->size)
 			> sizeof(struct mousevsc_prt_msg)) {
 			WARN_ON(1);
 			break;
 		}
 
 		memcpy(&input_dev->protocol_resp, pipe_msg,
-		       pipe_msg->size + sizeof(struct pipe_prt_msg) -
-		       sizeof(unsigned char));
+				struct_size(pipe_msg, data, pipe_msg->size));
 		complete(&input_dev->wait_event);
 		break;
 
@@ -359,8 +357,7 @@ static int mousevsc_connect_to_vsp(struct hv_device *device)
 	request->request.version_requested.version = SYNTHHID_INPUT_VERSION;
 
 	ret = vmbus_sendpacket(device->channel, request,
-				sizeof(struct pipe_prt_msg) -
-				sizeof(unsigned char) +
+				sizeof(struct pipe_prt_msg) +
 				sizeof(struct synthhid_protocol_request),
 				(unsigned long)request,
 				VM_PKT_DATA_INBAND,
-- 
2.37.3

