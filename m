Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 313CE473BF9
	for <lists+linux-hyperv@lfdr.de>; Tue, 14 Dec 2021 05:28:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233600AbhLNE2S (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 13 Dec 2021 23:28:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229513AbhLNE2S (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 13 Dec 2021 23:28:18 -0500
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9FF0C061574
        for <linux-hyperv@vger.kernel.org>; Mon, 13 Dec 2021 20:28:17 -0800 (PST)
Received: by mail-ed1-x52f.google.com with SMTP id g14so58019545edb.8
        for <linux-hyperv@vger.kernel.org>; Mon, 13 Dec 2021 20:28:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=dLaK46HWYZq7snZCQggrzzlXuL7uOm/8SZi0Jmv5Tc0=;
        b=iXdUdOn8AISHaNsBpe4MIk3M62H5DUvOq/pXtBWWLO1OcBvUkvH0QOLk+Tx970FTTS
         2Ddsk1j5COHJ110sRZDaFhkDpvt0UL0otTwDHff0EG6Xpy2n0qMnBy3RstIV2PRQgeHw
         TmsgJDnIebXWBygL3VWIkFsW4jqyGAvG/0yFSq2aqxAvLXWOoMf5akfxh6CYIAdrGEUL
         6ydOihstMcdwmfNgTdhWvvGautWAadr2EQmTt9rZU6EktU9ZbYiypzdast4S+LGf1XC8
         Pa51Ud7iL6UvBNk7aXNEXt+03BVTP4JtMqKHQKdcuwr/PflOmp4ymK/u7nkTpaEE1vl5
         ry3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=dLaK46HWYZq7snZCQggrzzlXuL7uOm/8SZi0Jmv5Tc0=;
        b=OSG2bie9yxB7BkEDI7uoRFsuTpxVDwF+dJgq6rrbwH3VwqsR2QdhNZrrogCi93uWvp
         EXqxeQrkCjoCBsctqt+uo67b7krzHwdOimKvFPoZGOJ9gQ30eFmOPU3lraanCy5fmGsB
         OOvk0IE0IIQfkUblM757CgHq6RUlQWQwQCVvbSl+/BcC0Ya7rCoZSat3n/QWxYdxdApE
         UKMpp0mRZWkEr2YZnxL7BKSotQ1fmkJ5EBTK7omPPccU7Ptuxqom4R9JVhebvspZZhPK
         4wC/4ct8EPqWiOlqUj9VUVBMsP9EcKv3LFN8O+G3XnvdbAsz4C/m/2ndJnvcNLAgVsWQ
         GzBQ==
X-Gm-Message-State: AOAM531Dqn+ZpteB3QKY5uh5wA3if4p7sOtSYVXTz4Ex+ZgArm78I47t
        RF+dAvpbh6UpwME7W63WoeVRiB4MaMc=
X-Google-Smtp-Source: ABdhPJzDUxyiqOk7Aehz3h+qG1FxANtQODLJAJNN2lIl0hLCPKuT8SF4K7PvU8bg8zVEQY7AQhxFGg==
X-Received: by 2002:a17:906:b84f:: with SMTP id ga15mr3171914ejb.4.1639456096197;
        Mon, 13 Dec 2021 20:28:16 -0800 (PST)
Received: from anparri (host-79-23-180-143.retail.telecomitalia.it. [79.23.180.143])
        by smtp.gmail.com with ESMTPSA id n8sm7235319edy.4.2021.12.13.20.28.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Dec 2021 20:28:15 -0800 (PST)
Date:   Tue, 14 Dec 2021 05:28:04 +0100
From:   Andrea Parri <parri.andrea@gmail.com>
To:     Yanming Liu <yanminglr@gmail.com>
Cc:     linux-hyperv@vger.kernel.org, Andres Beltran <lkmlabelt@gmail.com>,
        Dexuan Cui <decui@microsoft.com>, Wei Liu <wei.liu@kernel.org>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Michael Kelley <mikelley@microsoft.com>
Subject: Re: [PATCH] hv: account for packet descriptor in maximum packet size
Message-ID: <20211214042804.GA1934@anparri>
References: <20211212121326.215377-1-yanminglr@gmail.com>
 <20211213014709.GA2316@anparri>
 <CAH+BkoF-Y55MCSoFes3QYJqXEEH3ZsjHMjmtrKmN3UHv9S_0iw@mail.gmail.com>
 <20211214020658.GA439610@anparri>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211214020658.GA439610@anparri>
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Tue, Dec 14, 2021 at 03:06:58AM +0100, Andrea Parri wrote:
> > Truncated packet:
> > module("hv_vmbus").statement("hv_pkt_iter_first@drivers/hv/ring_buffer.c:457"):
> > desc->offset8 = 2, desc->len8 = 514, rbi->pkt_buffer_size = 4096
> > module("hv_vmbus").statement("hv_ringbuffer_read@drivers/hv/ring_buffer.c:382"):
> > desc->offset8 = 2, desc->len8 = 512
> > balloon_onchannelcallback: recvlen = 4080, dm_hdr->type = 8
> > 
> > First garbage packet:
> > module("hv_vmbus").statement("hv_pkt_iter_first@drivers/hv/ring_buffer.c:457"):
> > desc->offset8 = 21, desc->len8 = 16640, rbi->pkt_buffer_size = 4096
> > module("hv_vmbus").statement("hv_ringbuffer_read@drivers/hv/ring_buffer.c:382"):
> > desc->offset8 = 21, desc->len8 = 512
> > balloon_onchannelcallback: recvlen = 3928, dm_hdr->type = 63886
> > 
> > The trace proved my hypothesis above.
> 
> Thanks for the confirmation.
> 
> (Back to "how to fix this" now.) I think that the patch properly addresses
> the "mismatch" between the (maximum) size of the receive buffer (bufferlen
> in vmbus_recvpacket()) and max_pkt_size:
> 
> We've discussed hv_ballon in some:
> 
>   1) drivers/hv/hv_balloon.c:balloon_onchannelcallback()
>      (bufferlen = HV_HYP_PAGE_SIZE, max_pkt_size = VMBUS_DEFAULT_MAX_PKT_SIZE)
> 
> But I understand that the same mismatch is present *and addressed by your
> patch in the following cases:
> 
>   2) drivers/hv/hv_util.c:{shutdown,timesync,heartbeat}_onchannelcallback()
>      (bufferlen = HV_HYP_PAGE_SIZE, max_pkt_size = VMBUS_DEFAULT_MAX_PKT_SIZE)
> 
>   3) drivers/hv/hv_fcopy.c:hv_fcopy_onchannelcallback()
>      (bufferlen = 2 * HV_HYP_PAGE_SIZE, max_pkt_size = 2 * HV_HYP_PAGE_SIZE)
> 
>   4) drivers/hv/hv_snapshot.c:hv_vss_onchannelcallback()
>      (bufferlen= 2 * HV_HYP_PAGE_SIZE, max_pkt_size= 2 * HV_HYP_PAGE_SIZE)
> 
>   5) drivers/hv/hv_kvp.c:hv_kvp_onchannelcallback()
>      (bufferlen= 4 * HV_HYP_PAGE_SIZE, max_pkt_size= 4 * HV_HYP_PAGE_SIZE)
> 
> In fact, IIUC, similar considerations would apply to hv_fb and hv_drm *if
> it were not for the fact that those drivers seem to have bogus values for
> max_pkt_size:
> 
>   6) drivers/video/fbdev/hyperv_fb.c
>      (bufferlen = MAX_VMBUS_PKT_SIZE, max_pkt_size=VMBUS_DEFAULT_MAX_PKT_SIZE)
> 
>   7) drivers/gpu/drm/hyperv/hyperv_drm_proto.c
>      (bufferlen = MAX_VMBUS_PKT_SIZE, max_pkt_size=VMBUS_DEFAULT_MAX_PKT_SIZE)
> 
> So, IIUC, some separate patch is needed in order to "adjust" those values
> (say, by appropriately setting max_pkt_size in synthvid_connect_vsp() and
> in hyperv_connect_vsp()), but I digress.
> 
> Other comments on your patch:
> 
>   a) You mentioned the problem that "pkt_offset may not match the packet
>      descriptor size".  I think this is a real problem.  To address this
>      problem, we can *presumably consider HV_HYP_PAGE_SIZE to be a valid
>      upper bound for pkt_offset (and sizeof(struct vmpacket_descriptor))
>      *and increase the value of max_pkt_size by HV_HYP_PAGE_SIZE (rather
>      than sizeof(struct vmpacket_descriptor)), like in:
> 
> @@ -256,6 +256,7 @@ int hv_ringbuffer_init(struct hv_ring_buffer_info *ring_info,
>  
>  	/* Initialize buffer that holds copies of incoming packets */
>  	if (max_pkt_size) {
> +		max_pkt_size += HV_HYP_PAGE_SIZE;
>  		ring_info->pkt_buffer = kzalloc(max_pkt_size, GFP_KERNEL);
>  		if (!ring_info->pkt_buffer)
>  			return -ENOMEM;
> 
>   b) We may then want to "enforce"/check that that bound on pkt_offset,
> 
>         pkt_offset <= HV_HYP_PAGE_SIZE,
> 
>      is met by adding a corresponding check to the (previously discussed)
>      validation of pkt_offset included in hv_pkt_iter_first(), say:
> 
> @@ -498,7 +498,8 @@ struct vmpacket_descriptor *hv_pkt_iter_first(struct vmbus_channel *channel)
>  	 * If pkt_offset is invalid, arbitrarily set it to
>  	 * the size of vmpacket_descriptor
>  	 */
> -	if (pkt_offset < sizeof(struct vmpacket_descriptor) || pkt_offset > pkt_len)
> +	if (pkt_offset < sizeof(struct vmpacket_descriptor) || pkt_offset > pkt_len ||
> +			pkt_offset > HV_HYP_PAGE_SIZE)
>  		pkt_offset = sizeof(struct vmpacket_descriptor);
>  
>  	/* Copy the Hyper-V packet out of the ring buffer */
> 
>      While there (since I have noticed that such validation as well the
>      validation on pkt_len in hv_pkt_iter_first() tend to be the object
>      of a somehow recurring discussion ;/), I wouldn't mind to add some
>      "explicit" debug, pr_err_ratelimited() say, there.
> 
>   c) Last but not least, I'd recommend to pair the above changes or any
>      other change with some inline explanation/comments; these comments
>      could be snippets from an (updated) patch description for example.
> 
>   Andrea

One more thought.  The additional HV_HYP_PAGE_SIZE seems unnecessary for
drivers such as hv_netvsc and hv_storvsc, which explicitly account for
pkt_offset in their setting of max_pkt_size, as well as for drivers such
as hv_pci, which uses vmbus_recvpacket_raw().

This suggests an alternative approach: do not increase max_pkt_size in
the generic vmbus code, instead set/adjust max_pkt_size (only) for the
drivers, in (1-7) above, which require the additional HV_HYP_PAGE_SIZE
/pkt_offset.  While putting on the driver(s) some additional "burden",
this approach has the advantage of saving some memory (and keeping the
generic code relatively simpler).

Thoughts?

  Andrea
