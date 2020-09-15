Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3169726A040
	for <lists+linux-hyperv@lfdr.de>; Tue, 15 Sep 2020 09:55:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726247AbgIOHyu (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 15 Sep 2020 03:54:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726212AbgIOHxj (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 15 Sep 2020 03:53:39 -0400
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7314DC06174A;
        Tue, 15 Sep 2020 00:53:38 -0700 (PDT)
Received: by mail-ej1-x642.google.com with SMTP id j11so3721231ejk.0;
        Tue, 15 Sep 2020 00:53:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ks0EcIEGIK3AL4qrGbg0K7L3TxGS5zRG2FJAe08U/nI=;
        b=ltM9vprMJ7YIEK7/iTKJLI6oQqGgV6KP6ymY+BdP8uNwHVs4BaSWMddqU+sJ29pUjh
         zHaCNvt1Bg83H7Fpe0X8PFcrA4u24WIClcwJuY+VF2JRAbF4cjpocbuE6aArgDc0IJHs
         2Xpy2OypBp9Dldtm9+e02YEeUcDL3sITMHnTkyn6TDkmmCdWj3Rg1gqj11LLZ+8WEG6m
         TK1pC1EOhKCAKpsthRzEHYQsrZ+q8vZu7Sm/aVo82RCcTRKRENQyI/d6KL+VvAzG6TxO
         GAqB3X49/If0dNao5s5tve6GLM17FACMokLYF7c34xxIMVE2Sai+SBzXIRKv3FeGHqM8
         px+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ks0EcIEGIK3AL4qrGbg0K7L3TxGS5zRG2FJAe08U/nI=;
        b=WBtz+nQwHuVPdwH7ldr9zEU1cZvpqI086Qeqcys7oR2xyX/H7HpjG+9uEOdl1HKtNV
         BLDHXkb9FFLg76+CxwVOf19RuvZ+TnB+wqVT6XYK0pSWLS8awc9N6wCcLKjlILqax4K+
         CQdfnisEBvPFqluhsHNvHc8S0aaE56f+glbYK39KFkSDvbTSoMHUT0ChrgfmijhGrZJq
         BQMCx8CoEgc8mV4gVM40F+RFonJt4kQWwoVodL3C30PcntG86YQ1bZjWC2iYjyTfSkZe
         vxSDB477wzB9Yaa4qm4Xybpi6qa2FSIdLfO5wGGdoqCwpfIBPh3WpLN5JJ8uljOE+KzB
         OD/g==
X-Gm-Message-State: AOAM533NHJiClpFQRD55TD0KQxDkQrGqqWzfehekGEt4CvS5nfNGtBHp
        8UXxLvgkQTn1kgzDuz5wY68=
X-Google-Smtp-Source: ABdhPJw6qDBCaExBI5AnvnzlDdpEJo0TMuWAcJfhh+lGKXnH+/0Og9/eQTD6EPe1c9KOT29FmaIKWQ==
X-Received: by 2002:a17:906:a293:: with SMTP id i19mr19146423ejz.428.1600156416855;
        Tue, 15 Sep 2020 00:53:36 -0700 (PDT)
Received: from andrea (ip-213-220-210-175.net.upcbroadband.cz. [213.220.210.175])
        by smtp.gmail.com with ESMTPSA id q1sm5436583ejy.37.2020.09.15.00.53.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Sep 2020 00:53:36 -0700 (PDT)
Date:   Tue, 15 Sep 2020 09:53:30 +0200
From:   Andrea Parri <parri.andrea@gmail.com>
To:     Michael Kelley <mikelley@microsoft.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        Andres Beltran <lkmlabelt@gmail.com>,
        Saruhan Karademir <skarade@microsoft.com>,
        Juan Vazquez <juvazq@microsoft.com>
Subject: Re: [PATCH v7 1/3] Drivers: hv: vmbus: Add vmbus_requestor data
 structure for VMBus hardening
Message-ID: <20200915075253.GA3235@andrea>
References: <20200907161920.71460-1-parri.andrea@gmail.com>
 <20200907161920.71460-2-parri.andrea@gmail.com>
 <MW2PR2101MB1052338B4D3B7020A2191EB7D7280@MW2PR2101MB1052.namprd21.prod.outlook.com>
 <20200908075216.GA5638@andrea>
 <MW2PR2101MB1052FD464D63F86B4DD1BE7BD7230@MW2PR2101MB1052.namprd21.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <MW2PR2101MB1052FD464D63F86B4DD1BE7BD7230@MW2PR2101MB1052.namprd21.prod.outlook.com>
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Mon, Sep 14, 2020 at 05:29:11PM +0000, Michael Kelley wrote:
> From: Andrea Parri <parri.andrea@gmail.com> Sent: Tuesday, September 8, 2020 12:54 AM
> > 
> > > > @@ -300,6 +303,22 @@ int hv_ringbuffer_write(struct vmbus_channel *channel,
> > > >  						     kv_list[i].iov_len);
> > > >  	}
> > > >
> > > > +	/*
> > > > +	 * Allocate the request ID after the data has been copied into the
> > > > +	 * ring buffer.  Once this request ID is allocated, the completion
> > > > +	 * path could find the data and free it.
> > > > +	 */
> > > > +
> > > > +	if (desc->flags == VMBUS_DATA_PACKET_FLAG_COMPLETION_REQUESTED) {
> > > > +		rqst_id = vmbus_next_request_id(&channel->requestor, requestid);
> > > > +		if (rqst_id == VMBUS_RQST_ERROR) {
> > > > +			pr_err("No request id available\n");
> > > > +			return -EAGAIN;
> > > > +		}
> > > > +	}
> > > > +	desc = hv_get_ring_buffer(outring_info) + old_write;
> > > > +	desc->trans_id = (rqst_id == VMBUS_NO_RQSTOR) ? requestid : rqst_id;
> > > > +
> > >
> > > This is a nit, but the above would be clearer to me if written like this:
> > >
> > > 	flags = desc->flags;
> > > 	if (flags == VMBUS_DATA_PACKET_FLAG_COMPLETION_REQUESTED) {
> > > 		rqst_id = vmbus_next_request_id(&channel->requestor, requestid);
> > > 		if (rqst_id == VMBUS_RQST_ERROR) {
> > > 			pr_err("No request id available\n");
> > > 			return -EAGAIN;
> > > 		}
> > > 	} else {
> > > 		rqst_id = requestid;
> > > 	}
> > > 	desc = hv_get_ring_buffer(outring_info) + old_write;
> > > 	desc->trans_id = rqst_id;
> > >
> > > The value of the flags field controls what will be used as the value for the
> > > rqst_id.  Having another test to see which value will be used as the trans_id
> > > somehow feels a bit redundant.  And then rqst_id doesn't have to be initialized.
> > 
> > Agreed, will apply in the next version.
> > 
> 
> In an offline conversation, Andrea has pointed out that my proposed changes
> don't work.  After a second look, I'll agreed that Andrea's code is the best that
> can be done, so my comments can be ignored.

Thanks for the confirmation, Michael.  So, I plan to keep this patch as
is for the next submission of the series (to be submitted shortly...).

Thanks,
  Andrea
