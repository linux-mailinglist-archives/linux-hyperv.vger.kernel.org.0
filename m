Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B8FC4260C8A
	for <lists+linux-hyperv@lfdr.de>; Tue,  8 Sep 2020 09:54:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729714AbgIHHyP (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 8 Sep 2020 03:54:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729626AbgIHHyO (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 8 Sep 2020 03:54:14 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89FBEC061573;
        Tue,  8 Sep 2020 00:54:14 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id t10so18075322wrv.1;
        Tue, 08 Sep 2020 00:54:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=VFM2qpQbpbL3uttOIUsFCeXRmUsRSdv+VCKIwAroQcw=;
        b=lQi+T3SSV5dBWYS6GNHhsz3RcUzl0e4q3G/qps6vBHvy2n/98o6oLLVv9K28ugzOj1
         UPiVIUQKyH5v4qh4iqI3awOwzDLBxVzXeqK+oy9QCQvrJ+a0E7edBQBEbBRvfrXwbjZ7
         wSIeQHI8OvhdqKWH5ZSWu6PmiQmOrzf08fUHL/fOcoyaMg3I686wii2ZE7wxerGSoxn2
         XQZALWafSssYGRGudFTdmGrVqN5zCl7f2CJZQY6ofGScBa+GRF0xpWxJr6wK3d9TrXYx
         QuL42fb+tM86EKDZF6FnV95EKN3jdIytyELnRkDLO83/4h5rc7CMluQxwI1mrrSIfzuM
         TcuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=VFM2qpQbpbL3uttOIUsFCeXRmUsRSdv+VCKIwAroQcw=;
        b=PpfmY5VJNrOOSMKJkPqN7MohLPWRMhlKAy8w5+lbWrFJF1wrQdzSPubyTs/tZ86IRJ
         q/xCP8pLKpiiU5sjwb66l3PCtNkNUPkqRTzgQO3RKERCdfDQyhGVOjQHP0CQqxV4ssuY
         sOIqy4zewX9LgD9as1w15Lrn1SG30ISYe+IWuO74AtgaCflDSxSHPJekDNvjEhGY91uK
         HSpajWka2G+PWxekCpK/5pTRLfEkM+DbdMJF4eKSFFNV7wHLEAXjvsRsZOFEF8/taSzC
         Xkho8+O0UbIgoi+NzNoUoIC/v5YG6q9H8bEoKWGK1PdA0Blq0V0q99nMNogugdPDAPM4
         P/Hw==
X-Gm-Message-State: AOAM532aGc+LL2ychbhrnHGmUgyL2lo2UcJd8ZPmwUDTdC1nfp0UpPgy
        0+bShS9Wv5kBfP6nX4X9bL5V0+MM0mFNjh3uTbg=
X-Google-Smtp-Source: ABdhPJw/PbopcC4U7Qil50C9VD7W1PfeoqHrQazUg1ImS4e6MstvvTBIj4o9fJ2Y8I4sfbLdssxuww==
X-Received: by 2002:adf:dcc3:: with SMTP id x3mr24892562wrm.120.1599551653054;
        Tue, 08 Sep 2020 00:54:13 -0700 (PDT)
Received: from andrea (userh713.uk.uudial.com. [194.69.103.86])
        by smtp.gmail.com with ESMTPSA id c145sm28695512wmd.7.2020.09.08.00.54.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Sep 2020 00:54:12 -0700 (PDT)
Date:   Tue, 8 Sep 2020 09:54:05 +0200
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
Message-ID: <20200908075216.GA5638@andrea>
References: <20200907161920.71460-1-parri.andrea@gmail.com>
 <20200907161920.71460-2-parri.andrea@gmail.com>
 <MW2PR2101MB1052338B4D3B7020A2191EB7D7280@MW2PR2101MB1052.namprd21.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <MW2PR2101MB1052338B4D3B7020A2191EB7D7280@MW2PR2101MB1052.namprd21.prod.outlook.com>
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

> > @@ -300,6 +303,22 @@ int hv_ringbuffer_write(struct vmbus_channel *channel,
> >  						     kv_list[i].iov_len);
> >  	}
> > 
> > +	/*
> > +	 * Allocate the request ID after the data has been copied into the
> > +	 * ring buffer.  Once this request ID is allocated, the completion
> > +	 * path could find the data and free it.
> > +	 */
> > +
> > +	if (desc->flags == VMBUS_DATA_PACKET_FLAG_COMPLETION_REQUESTED) {
> > +		rqst_id = vmbus_next_request_id(&channel->requestor, requestid);
> > +		if (rqst_id == VMBUS_RQST_ERROR) {
> > +			pr_err("No request id available\n");
> > +			return -EAGAIN;
> > +		}
> > +	}
> > +	desc = hv_get_ring_buffer(outring_info) + old_write;
> > +	desc->trans_id = (rqst_id == VMBUS_NO_RQSTOR) ? requestid : rqst_id;
> > +
> 
> This is a nit, but the above would be clearer to me if written like this:
> 
> 	flags = desc->flags;
> 	if (flags == VMBUS_DATA_PACKET_FLAG_COMPLETION_REQUESTED) {
> 		rqst_id = vmbus_next_request_id(&channel->requestor, requestid);
> 		if (rqst_id == VMBUS_RQST_ERROR) {
> 			pr_err("No request id available\n");
> 			return -EAGAIN;
> 		}
> 	} else {
> 		rqst_id = requestid;
> 	}
> 	desc = hv_get_ring_buffer(outring_info) + old_write;
> 	desc->trans_id = rqst_id;
> 
> The value of the flags field controls what will be used as the value for the
> rqst_id.  Having another test to see which value will be used as the trans_id
> somehow feels a bit redundant.  And then rqst_id doesn't have to be initialized.

Agreed, will apply in the next version.


> 
> >  	/* Set previous packet start */
> >  	prev_indices = hv_get_ring_bufferindices(outring_info);
> > 
> > @@ -319,8 +338,13 @@ int hv_ringbuffer_write(struct vmbus_channel *channel,
> > 
> >  	hv_signal_on_write(old_write, channel);
> > 
> > -	if (channel->rescind)
> > +	if (channel->rescind) {
> > +		if (rqst_id != VMBUS_NO_RQSTOR) {
> 
> Of course, with my proposed change, the above test would also have to be for
> the value of the flags field, which actually makes the code a bit more consistent.

Yes, indeed.  Thank you for the review and the suggestion.

  Andrea
