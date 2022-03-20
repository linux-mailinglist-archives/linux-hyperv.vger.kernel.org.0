Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4733A4E1C20
	for <lists+linux-hyperv@lfdr.de>; Sun, 20 Mar 2022 15:58:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244144AbiCTPAI (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Sun, 20 Mar 2022 11:00:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234277AbiCTPAH (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Sun, 20 Mar 2022 11:00:07 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA277252A7;
        Sun, 20 Mar 2022 07:58:42 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id h13so15317967ede.5;
        Sun, 20 Mar 2022 07:58:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=6CWKYqtc6RNurgp1Shg9+uzBqze9ab4UhblI0+K5cmI=;
        b=PGK/WAiBLLLv1ANzctUPJNhTeChLRPH2mcx474dFIyf1wx2B8stuR5QqcZEQXSLDwR
         KNTM4ry7OcNw2kw8PzF42T6fV7U/fV4rji78zUg6qU96Y/sXtkMYvPeBkQMA39kLOxbp
         dUkDomsawh1vzNFC8eIUcbMXfv3EBky41qugGgJBpX0CJkGTE3OMrGv7MFY/cWF37Lei
         dsK7VC8UjIN3bfIjzBGQK3+dJe9tjgDYGIe1RY+ikUJDnmkimleBl3IayqxR7k+Xq+Rr
         YItqBLDFCLdxEtpzoSZxx7vZzZ07pJx1NVArgDSWElQ1o28pQocK0f3h2geYSspU2vBO
         Tedw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=6CWKYqtc6RNurgp1Shg9+uzBqze9ab4UhblI0+K5cmI=;
        b=iC8Qdyu3IYCkjZjFTv7LqxAz/7NE5OHvEkYfnFkpsIS9swG0LWaqXlpqqFjRyK+rm1
         Eqf2AmlvKuvnVrp5SQLnsFNZs5AtGqUooXEui25UXub7QeNxV8Avg1SmAOso8bZUQbt1
         q2RXta7YZ95y43FEpYGAh5Z+a8BkVL8eku9KuiS7+TOZn1+92kPe3i7EhlV24gjpeDew
         bt6RcAwjNC4gyayuPFpZC3OBu75QQw8hm+fid3ubdm9cWn4J1xYF+koL1xw6CJxX83uv
         2HfaQRxwBmBww9VjdqEXGIzuGyq79YIS0BTQXL/EywxNMIdiPChCBg0/UCtTEoXYODoi
         0+WQ==
X-Gm-Message-State: AOAM531OmT2rQ6PsEmDgE9/KhbiTZwNRN8gJy4ejBr1mwOzvsIrK9cuy
        Y73N49LRwGI0wnmilbNEklI=
X-Google-Smtp-Source: ABdhPJwGPSVhIpLvxJg/c2edQLm4kUKv1BOGx7QLgyAAd7cNW2pLWB5MBPiQAAFD3IVIrqOPbr4qPQ==
X-Received: by 2002:a05:6402:4248:b0:416:9c69:4f80 with SMTP id g8-20020a056402424800b004169c694f80mr18798105edb.83.1647788320960;
        Sun, 20 Mar 2022 07:58:40 -0700 (PDT)
Received: from anparri (host-82-59-4-232.retail.telecomitalia.it. [82.59.4.232])
        by smtp.gmail.com with ESMTPSA id g11-20020a170906538b00b006ae38eb0561sm5970408ejo.195.2022.03.20.07.58.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Mar 2022 07:58:40 -0700 (PDT)
Date:   Sun, 20 Mar 2022 15:58:33 +0100
From:   Andrea Parri <parri.andrea@gmail.com>
To:     "Michael Kelley (LINUX)" <mikelley@microsoft.com>
Cc:     KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
        Wei Hu <weh@microsoft.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Wilczynski <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/2] PCI: hv: Use IDR to generate transaction IDs for
 VMBus hardening
Message-ID: <20220320145833.GA1393@anparri>
References: <20220318174848.290621-1-parri.andrea@gmail.com>
 <20220318174848.290621-2-parri.andrea@gmail.com>
 <PH0PR21MB3025016203AAB9AB6ECB6A3ED7149@PH0PR21MB3025.namprd21.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PH0PR21MB3025016203AAB9AB6ECB6A3ED7149@PH0PR21MB3025.namprd21.prod.outlook.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Sat, Mar 19, 2022 at 04:20:13PM +0000, Michael Kelley (LINUX) wrote:
> From: Andrea Parri (Microsoft) <parri.andrea@gmail.com> Sent: Friday, March 18, 2022 10:49 AM
> > 
> > Currently, pointers to guest memory are passed to Hyper-V as transaction
> > IDs in hv_pci.  In the face of errors or malicious behavior in Hyper-V,
> > hv_pci should not expose or trust the transaction IDs returned by
> > Hyper-V to be valid guest memory addresses.  Instead, use small integers
> > generated by IDR as request (transaction) IDs.
> 
> I had expected that this code would use the next_request_id_callback
> mechanism because of the race conditions that mechanism solves.  And
> to protect against a malicious Hyper-V sending a bogus second message
> with the same requestID, the requestID needs to be freed in the
> onchannelcallback function as is done with vmbus_request_addr().

I think I should elaborate on the design underlying this submission;
roughly, the present solution diverges from the 'generic' requestor
mechanism you mentioned above in two main aspects:

  A) it 'moves' the ID removal into hv_compose_msi_msg() and other
     functions,

  B) it adopts some ad-hoc locking scheme in the channel callback.

AFAICT, such changes preserve the 'confidentiality' and correctness
guarantees of the generic approach (modulo the issue discussed here
with Saurabh).

These changes are justified by the bug/fix discussed in 2/2.  For
concreteness, consider a solution based on the VMbus requestor as
reported at the end of this email.

AFAICT, this solution can't fix the bug discussed in 2/2.  Moreover
(and looking back at (A-B)), we observe that:

  1) locking in the channel callback is not quite as desired: we'd
     want a request_addr_callback_nolock() say and 'protected' it
     together with ->completion_func();

  2) hv_compose_msi_msg() doesn't know the value of the request ID
     it has allocated (hv_compose_msi_msg() -> vmbus_sendpacket();
     cf. also remove_request_id() in the current submission).

Hope this helps clarify the problems at stake, and move fortward to a
'final' solution...

Thanks,
  Andrea


diff --git a/drivers/pci/controller/pci-hyperv.c b/drivers/pci/controller/pci-hyperv.c
index ae0bc2fee4ca8..bd99dd12d367b 100644
--- a/drivers/pci/controller/pci-hyperv.c
+++ b/drivers/pci/controller/pci-hyperv.c
@@ -91,6 +91,9 @@ static enum pci_protocol_version_t pci_protocol_versions[] = {
 /* space for 32bit serial number as string */
 #define SLOT_NAME_SIZE 11
 
+/* Size of requestor for VMbus */
+#define HV_PCI_RQSTOR_SIZE 64
+
 /*
  * Message Types
  */
@@ -1407,7 +1410,7 @@ static void hv_int_desc_free(struct hv_pci_dev *hpdev,
 	int_pkt->wslot.slot = hpdev->desc.win_slot.slot;
 	int_pkt->int_desc = *int_desc;
 	vmbus_sendpacket(hpdev->hbus->hdev->channel, int_pkt, sizeof(*int_pkt),
-			 (unsigned long)&ctxt.pkt, VM_PKT_DATA_INBAND, 0);
+			 0, VM_PKT_DATA_INBAND, 0);
 	kfree(int_desc);
 }
 
@@ -2649,7 +2652,7 @@ static void hv_eject_device_work(struct work_struct *work)
 	ejct_pkt->message_type.type = PCI_EJECTION_COMPLETE;
 	ejct_pkt->wslot.slot = hpdev->desc.win_slot.slot;
 	vmbus_sendpacket(hbus->hdev->channel, ejct_pkt,
-			 sizeof(*ejct_pkt), (unsigned long)&ctxt.pkt,
+			 sizeof(*ejct_pkt), 0,
 			 VM_PKT_DATA_INBAND, 0);
 
 	/* For the get_pcichild() in hv_pci_eject_device() */
@@ -2696,8 +2699,9 @@ static void hv_pci_onchannelcallback(void *context)
 	const int packet_size = 0x100;
 	int ret;
 	struct hv_pcibus_device *hbus = context;
+	struct vmbus_channel *chan = hbus->hdev->channel;
 	u32 bytes_recvd;
-	u64 req_id;
+	u64 req_id, req_addr;
 	struct vmpacket_descriptor *desc;
 	unsigned char *buffer;
 	int bufferlen = packet_size;
@@ -2743,11 +2747,13 @@ static void hv_pci_onchannelcallback(void *context)
 		switch (desc->type) {
 		case VM_PKT_COMP:
 
-			/*
-			 * The host is trusted, and thus it's safe to interpret
-			 * this transaction ID as a pointer.
-			 */
-			comp_packet = (struct pci_packet *)req_id;
+			req_addr = chan->request_addr_callback(chan, req_id);
+			if (!req_addr || req_addr == VMBUS_RQST_ERROR) {
+				dev_warn_ratelimited(&hbus->hdev->device,
+						     "Invalid request ID\n");
+				break;
+			}
+			comp_packet = (struct pci_packet *)req_addr;
 			response = (struct pci_response *)buffer;
 			comp_packet->completion_func(comp_packet->compl_ctxt,
 						     response,
@@ -3419,6 +3425,10 @@ static int hv_pci_probe(struct hv_device *hdev,
 		goto free_dom;
 	}
 
+	hdev->channel->next_request_id_callback = vmbus_next_request_id;
+	hdev->channel->request_addr_callback = vmbus_request_addr;
+	hdev->channel->rqstor_size = HV_PCI_RQSTOR_SIZE;
+
 	ret = vmbus_open(hdev->channel, pci_ring_size, pci_ring_size, NULL, 0,
 			 hv_pci_onchannelcallback, hbus);
 	if (ret)
@@ -3749,6 +3759,10 @@ static int hv_pci_resume(struct hv_device *hdev)
 
 	hbus->state = hv_pcibus_init;
 
+	hdev->channel->next_request_id_callback = vmbus_next_request_id;
+	hdev->channel->request_addr_callback = vmbus_request_addr;
+	hdev->channel->rqstor_size = HV_PCI_RQSTOR_SIZE;
+
 	ret = vmbus_open(hdev->channel, pci_ring_size, pci_ring_size, NULL, 0,
 			 hv_pci_onchannelcallback, hbus);
 	if (ret)
