Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D5889473A91
	for <lists+linux-hyperv@lfdr.de>; Tue, 14 Dec 2021 03:07:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243875AbhLNCHJ (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 13 Dec 2021 21:07:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244126AbhLNCHI (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 13 Dec 2021 21:07:08 -0500
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26BE9C06173F
        for <linux-hyperv@vger.kernel.org>; Mon, 13 Dec 2021 18:07:08 -0800 (PST)
Received: by mail-ed1-x536.google.com with SMTP id v1so58551598edx.2
        for <linux-hyperv@vger.kernel.org>; Mon, 13 Dec 2021 18:07:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Vby2uKZTvN7vtMmfFE69GbZd2lhIEKXiavWrvnGhxJc=;
        b=NjZsLlQswuD03v0ZjW+D02ioO2E/aMRhU3nwZNfCLPGnmGlTEBAPNb9/2N/om3Ze3u
         vbxweAld/KICw7uMAg111EaKRF4SG2jSKyScgRVFeXEXR+FtF84vETr/Y1fjtRSSQGfy
         hXDFd1cpGi/CRZuyIwPKnFlApCzTFYGGMAkV5JW2l8rRGPnwYLbqP4aDJ0jLH4t7WMrg
         KT5dc2wGqPiTUTogi17lMyEtgpcJPKNONN6sSFQAhxIOnJbnxbhM/vKXtiyXY5ZeC61f
         5kHy0/SbBRlVHbOWFWQ6mt4VkpyzaWtqLsYwx5ecfERJO7t1DSl9hGj2mjMJwLeomgba
         Mwmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Vby2uKZTvN7vtMmfFE69GbZd2lhIEKXiavWrvnGhxJc=;
        b=32x/DP47J79zVSr5CYGmc2m3PSHCf1+J7uL8uW/G9hDABkh5flowdMG0JGJl0sBXnd
         V0s2n5JcI1SdPw+RbQ9g5SO7Uiypp9ZCfG051kPQj1NVuF41pFooQbqOUUW9rjFfGj9g
         +NzTFUi800ESCh0KxtQS5uOpc17emFuaI2Az/EGV6LAsiv48SD2H3V9sX6ehaYmmSK6X
         OFamLwRrT1nPgmRVHFMgKDw5vhN7gkKv7f6je9LJOMjb/FEQ0NQMYId2ccMBPLnPpwre
         EZFgY1vIde248pWi3Bqg/RnwqDzynvB/efPzxDjBlJ3ZcIkIhDuP2fdYVgFcWTaRNFLu
         3jyQ==
X-Gm-Message-State: AOAM533/VM44JXcD4SLsIjGwcNdimm6l+7hNjg4x6cWri1tMG4/WANSt
        jO5bDCu/hQtAWVs5jrGlOW8=
X-Google-Smtp-Source: ABdhPJyu55wrR4He8mqsLI8OyNGis/KGOsj4JL3/j8RF208MfXxVd5TLIbLN1hRLoPhu2SCsbYI7xQ==
X-Received: by 2002:a05:6402:3594:: with SMTP id y20mr3565171edc.328.1639447626627;
        Mon, 13 Dec 2021 18:07:06 -0800 (PST)
Received: from anparri (host-79-23-180-143.retail.telecomitalia.it. [79.23.180.143])
        by smtp.gmail.com with ESMTPSA id cs15sm5998921ejc.31.2021.12.13.18.07.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Dec 2021 18:07:06 -0800 (PST)
Date:   Tue, 14 Dec 2021 03:06:58 +0100
From:   Andrea Parri <parri.andrea@gmail.com>
To:     Yanming Liu <yanminglr@gmail.com>
Cc:     linux-hyperv@vger.kernel.org, Andres Beltran <lkmlabelt@gmail.com>,
        Dexuan Cui <decui@microsoft.com>, Wei Liu <wei.liu@kernel.org>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Michael Kelley <mikelley@microsoft.com>
Subject: Re: [PATCH] hv: account for packet descriptor in maximum packet size
Message-ID: <20211214020658.GA439610@anparri>
References: <20211212121326.215377-1-yanminglr@gmail.com>
 <20211213014709.GA2316@anparri>
 <CAH+BkoF-Y55MCSoFes3QYJqXEEH3ZsjHMjmtrKmN3UHv9S_0iw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAH+BkoF-Y55MCSoFes3QYJqXEEH3ZsjHMjmtrKmN3UHv9S_0iw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

> Truncated packet:
> module("hv_vmbus").statement("hv_pkt_iter_first@drivers/hv/ring_buffer.c:457"):
> desc->offset8 = 2, desc->len8 = 514, rbi->pkt_buffer_size = 4096
> module("hv_vmbus").statement("hv_ringbuffer_read@drivers/hv/ring_buffer.c:382"):
> desc->offset8 = 2, desc->len8 = 512
> balloon_onchannelcallback: recvlen = 4080, dm_hdr->type = 8
> 
> First garbage packet:
> module("hv_vmbus").statement("hv_pkt_iter_first@drivers/hv/ring_buffer.c:457"):
> desc->offset8 = 21, desc->len8 = 16640, rbi->pkt_buffer_size = 4096
> module("hv_vmbus").statement("hv_ringbuffer_read@drivers/hv/ring_buffer.c:382"):
> desc->offset8 = 21, desc->len8 = 512
> balloon_onchannelcallback: recvlen = 3928, dm_hdr->type = 63886
> 
> The trace proved my hypothesis above.

Thanks for the confirmation.

(Back to "how to fix this" now.) I think that the patch properly addresses
the "mismatch" between the (maximum) size of the receive buffer (bufferlen
in vmbus_recvpacket()) and max_pkt_size:

We've discussed hv_ballon in some:

  1) drivers/hv/hv_balloon.c:balloon_onchannelcallback()
     (bufferlen = HV_HYP_PAGE_SIZE, max_pkt_size = VMBUS_DEFAULT_MAX_PKT_SIZE)

But I understand that the same mismatch is present *and addressed by your
patch in the following cases:

  2) drivers/hv/hv_util.c:{shutdown,timesync,heartbeat}_onchannelcallback()
     (bufferlen = HV_HYP_PAGE_SIZE, max_pkt_size = VMBUS_DEFAULT_MAX_PKT_SIZE)

  3) drivers/hv/hv_fcopy.c:hv_fcopy_onchannelcallback()
     (bufferlen = 2 * HV_HYP_PAGE_SIZE, max_pkt_size = 2 * HV_HYP_PAGE_SIZE)

  4) drivers/hv/hv_snapshot.c:hv_vss_onchannelcallback()
     (bufferlen= 2 * HV_HYP_PAGE_SIZE, max_pkt_size= 2 * HV_HYP_PAGE_SIZE)

  5) drivers/hv/hv_kvp.c:hv_kvp_onchannelcallback()
     (bufferlen= 4 * HV_HYP_PAGE_SIZE, max_pkt_size= 4 * HV_HYP_PAGE_SIZE)

In fact, IIUC, similar considerations would apply to hv_fb and hv_drm *if
it were not for the fact that those drivers seem to have bogus values for
max_pkt_size:

  6) drivers/video/fbdev/hyperv_fb.c
     (bufferlen = MAX_VMBUS_PKT_SIZE, max_pkt_size=VMBUS_DEFAULT_MAX_PKT_SIZE)

  7) drivers/gpu/drm/hyperv/hyperv_drm_proto.c
     (bufferlen = MAX_VMBUS_PKT_SIZE, max_pkt_size=VMBUS_DEFAULT_MAX_PKT_SIZE)

So, IIUC, some separate patch is needed in order to "adjust" those values
(say, by appropriately setting max_pkt_size in synthvid_connect_vsp() and
in hyperv_connect_vsp()), but I digress.

Other comments on your patch:

  a) You mentioned the problem that "pkt_offset may not match the packet
     descriptor size".  I think this is a real problem.  To address this
     problem, we can *presumably consider HV_HYP_PAGE_SIZE to be a valid
     upper bound for pkt_offset (and sizeof(struct vmpacket_descriptor))
     *and increase the value of max_pkt_size by HV_HYP_PAGE_SIZE (rather
     than sizeof(struct vmpacket_descriptor)), like in:

@@ -256,6 +256,7 @@ int hv_ringbuffer_init(struct hv_ring_buffer_info *ring_info,
 
 	/* Initialize buffer that holds copies of incoming packets */
 	if (max_pkt_size) {
+		max_pkt_size += HV_HYP_PAGE_SIZE;
 		ring_info->pkt_buffer = kzalloc(max_pkt_size, GFP_KERNEL);
 		if (!ring_info->pkt_buffer)
 			return -ENOMEM;

  b) We may then want to "enforce"/check that that bound on pkt_offset,

        pkt_offset <= HV_HYP_PAGE_SIZE,

     is met by adding a corresponding check to the (previously discussed)
     validation of pkt_offset included in hv_pkt_iter_first(), say:

@@ -498,7 +498,8 @@ struct vmpacket_descriptor *hv_pkt_iter_first(struct vmbus_channel *channel)
 	 * If pkt_offset is invalid, arbitrarily set it to
 	 * the size of vmpacket_descriptor
 	 */
-	if (pkt_offset < sizeof(struct vmpacket_descriptor) || pkt_offset > pkt_len)
+	if (pkt_offset < sizeof(struct vmpacket_descriptor) || pkt_offset > pkt_len ||
+			pkt_offset > HV_HYP_PAGE_SIZE)
 		pkt_offset = sizeof(struct vmpacket_descriptor);
 
 	/* Copy the Hyper-V packet out of the ring buffer */

     While there (since I have noticed that such validation as well the
     validation on pkt_len in hv_pkt_iter_first() tend to be the object
     of a somehow recurring discussion ;/), I wouldn't mind to add some
     "explicit" debug, pr_err_ratelimited() say, there.

  c) Last but not least, I'd recommend to pair the above changes or any
     other change with some inline explanation/comments; these comments
     could be snippets from an (updated) patch description for example.

  Andrea
