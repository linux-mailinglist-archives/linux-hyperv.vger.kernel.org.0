Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68FAC4E3ECB
	for <lists+linux-hyperv@lfdr.de>; Tue, 22 Mar 2022 13:51:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231430AbiCVMxC (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 22 Mar 2022 08:53:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230049AbiCVMxB (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 22 Mar 2022 08:53:01 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA6ACE0A0;
        Tue, 22 Mar 2022 05:51:33 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id a8so35960748ejc.8;
        Tue, 22 Mar 2022 05:51:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=TKFjKWAaCF4H2cz+VJloGhXj3Wp4pEyNggKK9y2BrUE=;
        b=UcooYFvZ+488qpuOzPyRhq1slUM2DQN24rwpn/CpYHbOaN33zhz++3VA1YMjtMP8BJ
         XtL/1HWlnjHz7a/ghVgLwJyQkEQqTQ+UOgPzsxlkvVHJPdk0orXYABh8zXnnb/lMo5il
         OzozR8K4TACRlUHWcHLLs80cqoGGY/h4UvEoFKpz7UzbwWEiAHI5AqLe7W938YZByE0O
         HDCb0OykNygl1oHpqryfnVqSLbfXyZl7qrzsOcOO12PlV46VNQ0dBD7B96D9D+EVWTlx
         DSlQWo9ygHnepA4U/xWUIjVAy/ENdd6K1Afv1dE8dj5JfU7zJIgYeQMPh9wEJTEX29ys
         Halw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=TKFjKWAaCF4H2cz+VJloGhXj3Wp4pEyNggKK9y2BrUE=;
        b=ZDa/Ojr3n11MMoidBiojFib0OyOB9GMiRKyVZHhDBjezVxnIsLnOQf/OTTG5MpyMHq
         wWJJoBti51FyMswYPlBPFlWH5xXLrIpVlYgA2GlAh3FKjHPvoqApK8fVIyb93KVzjitV
         mLiMhMModx6OGyUT+DniwBCJUy92upPd8q0RZORFlNO2UuSCMs3UOjRZM9wcUDI4v57+
         evkMi097tvdd1k6Yqkc2gN8jn2knJqkNylCP/IK5PYEvmE/WcABKwx1HpOuWWpD60kJd
         waJcir4Bq4I2TTrM6SbHv4BD//1aavq7gp8Okvgec0b3cqqKE+ShFEy4JgcjPEyc8hIx
         9SFA==
X-Gm-Message-State: AOAM5331WbnJ3rVtyYZqWNcdmymsxHrSeMaqzc0yL7RWTlRCm5bb63Bp
        j9hAGHxiH6shT2tHn3TGiNM=
X-Google-Smtp-Source: ABdhPJyRw22b6w+fQUkpmr2TGGOQ9Mqh+x3XjLkpt8ll3SjGYajRJLgYqiI8/2r1fyzS8QIys2SMnA==
X-Received: by 2002:a17:906:c107:b0:6df:c114:e286 with SMTP id do7-20020a170906c10700b006dfc114e286mr18153971ejc.216.1647953491997;
        Tue, 22 Mar 2022 05:51:31 -0700 (PDT)
Received: from anparri (host-82-59-4-232.retail.telecomitalia.it. [82.59.4.232])
        by smtp.gmail.com with ESMTPSA id g13-20020a50bf4d000000b00410d407da2esm9780512edk.13.2022.03.22.05.51.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Mar 2022 05:51:31 -0700 (PDT)
Date:   Tue, 22 Mar 2022 13:51:22 +0100
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
Message-ID: <20220322125122.GA2158@anparri>
References: <20220318174848.290621-1-parri.andrea@gmail.com>
 <20220318174848.290621-2-parri.andrea@gmail.com>
 <PH0PR21MB3025016203AAB9AB6ECB6A3ED7149@PH0PR21MB3025.namprd21.prod.outlook.com>
 <20220320145833.GA1393@anparri>
 <PH0PR21MB3025C19EDC8F5230DB1957EBD7169@PH0PR21MB3025.namprd21.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PH0PR21MB3025C19EDC8F5230DB1957EBD7169@PH0PR21MB3025.namprd21.prod.outlook.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

> > I think I should elaborate on the design underlying this submission;
> > roughly, the present solution diverges from the 'generic' requestor
> > mechanism you mentioned above in two main aspects:
> > 
> >   A) it 'moves' the ID removal into hv_compose_msi_msg() and other
> >      functions,
> 
> Right.  A key implication is that this patch allows the completion
> function to be called multiple times, if Hyper-V were to be malicious
> and send multiple responses with the same requestID.  This is OK as
> long as the completion functions are idempotent, which after looking,
> I think they are in this driver.
> 
> Furthermore, this patch allows the completion function to run anytime
> between when the requestID is created and when it is deleted.  This
> patch creates the requestID just before calling vmbus_sendpacket(),
> which is good.  The requestID is deleted later in the various functions.
> I saw only one potential problem, which is in new_pcichild_device(),
> where the new hpdev is added to a global list before the requestID is
> deleted. There's a window where the completion function could run
> and update the probed_bar[] values asynchronously after the hpdev is
> on the global list.  I don't know if this is a problem or not, but it could
> be prevented by deleting the requestID a little earlier in the function.
> 
> > 
> >   B) it adopts some ad-hoc locking scheme in the channel callback.
> > 
> > AFAICT, such changes preserve the 'confidentiality' and correctness
> > guarantees of the generic approach (modulo the issue discussed here
> > with Saurabh).
> 
> Yes, I agree, assuming the current functionality of the completion
> functions.
> 
> > 
> > These changes are justified by the bug/fix discussed in 2/2.  For
> > concreteness, consider a solution based on the VMbus requestor as
> > reported at the end of this email.
> > 
> > AFAICT, this solution can't fix the bug discussed in 2/2.  Moreover
> > (and looking back at (A-B)), we observe that:
> > 
> >   1) locking in the channel callback is not quite as desired: we'd
> >      want a request_addr_callback_nolock() say and 'protected' it
> >      together with ->completion_func();
> 
> I'm not understanding this point.  Could you clarify?

Basically (on top of the previous diff):

@@ -2700,6 +2725,7 @@ static void hv_pci_onchannelcallback(void *context)
 	int ret;
 	struct hv_pcibus_device *hbus = context;
 	struct vmbus_channel *chan = hbus->hdev->channel;
+	struct vmbus_requestor *rqstor = &chan->requestor;
 	u32 bytes_recvd;
 	u64 req_id, req_addr;
 	struct vmpacket_descriptor *desc;
@@ -2713,6 +2739,7 @@ static void hv_pci_onchannelcallback(void *context)
 	struct pci_dev_inval_block *inval;
 	struct pci_dev_incoming *dev_message;
 	struct hv_pci_dev *hpdev;
+	unsigned long flags;
 
 	buffer = kmalloc(bufferlen, GFP_ATOMIC);
 	if (!buffer)
@@ -2747,8 +2774,10 @@ static void hv_pci_onchannelcallback(void *context)
 		switch (desc->type) {
 		case VM_PKT_COMP:
 
-			req_addr = chan->request_addr_callback(chan, req_id);
+			spin_lock_irqsave(&rqstor->req_lock, flags);
+			req_addr = __hv_pci_request_addr(chan, req_id);
 			if (!req_addr || req_addr == VMBUS_RQST_ERROR) {
+				spin_unlock_irqrestore(&rqstor->req_lock, flags);
 				dev_warn_ratelimited(&hbus->hdev->device,
 						     "Invalid request ID\n");
 				break;
@@ -2758,6 +2787,7 @@ static void hv_pci_onchannelcallback(void *context)
 			comp_packet->completion_func(comp_packet->compl_ctxt,
 						     response,
 						     bytes_recvd);
+			spin_unlock_irqrestore(&rqstor->req_lock, flags);
 			break;
 
 		case VM_PKT_DATA_INBAND:


where I renamed request_addr_callback_nolock() to __hv_pci_request_addr()
(this being as in vmbus_request_addr() but without the requestor lock).
A "locked" callback would still be wanted and used in, e.g., the failure
path of hv_ringbuffer_write().


> >   2) hv_compose_msi_msg() doesn't know the value of the request ID
> >      it has allocated (hv_compose_msi_msg() -> vmbus_sendpacket();
> >      cf. also remove_request_id() in the current submission).
> 
> Agreed.  This would have to be addressed by adding another version of
> vmbus_sendpacket() that returns the request ID.

Indeed...  Some care would be needed to make sure that that "ID removal"
can't "race" with hv_pci_onchannelcallback() (which could have removed
the ID now), but yes...


> > Hope this helps clarify the problems at stake, and move forward to a
> > 'final' solution...
> 
> I think there's a reasonable way for the vmbus_next_request_id()
> mechanism to solve the problem in Patch 2/2 (if a new version of
> vmbus_sendpacket is added).  To me, that mechanism seems safer
> in that it restricts the completion function to running just once
> per requestID.  With this patch, we must remember that the
> completion functions must remain idempotent.

Fair enough.  Thank you for bearing with me and patiently reviewing these
matters.  Working out the details...

Thanks,
  Andrea
