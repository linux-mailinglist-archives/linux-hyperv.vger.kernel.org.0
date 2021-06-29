Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5059F3B72AF
	for <lists+linux-hyperv@lfdr.de>; Tue, 29 Jun 2021 14:55:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233011AbhF2M5u (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 29 Jun 2021 08:57:50 -0400
Received: from mail-wr1-f42.google.com ([209.85.221.42]:33505 "EHLO
        mail-wr1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232755AbhF2M5t (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 29 Jun 2021 08:57:49 -0400
Received: by mail-wr1-f42.google.com with SMTP id i8so3472721wrc.0;
        Tue, 29 Jun 2021 05:55:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=c09axMTOtUdFn084x7QGWCEjh23Bflph50dJnZAUCI0=;
        b=slEgNLX32Gtn0HQJRsK2VF1t3q8blkraSpk+awmESrCN9xUQ1DxLn71QewjGTB1ekr
         N3fGLOwpZX8cu2zujCDcLni2+yhxVjq/5At/3TKoHxwPUTYl19D2L6kv6zian2ZIbfAA
         lHAMSaUDouC9bXKOutFoKsePdwdaikPDw3Rz/RdULqG28jQZbhQXdN5+ZRILboiBYQRf
         MO2Qh6qZhGOisYhr2ihmSDXB6vx8Pfi3SQTnJXRgCQb7Yekg1ScxAxwavADMmLOWQT60
         pGJscRNOYY3I8Gf71yE+7C4ywLTF+qoF542RIzUu9UKZu+m2V6cp7I/ZdD1zkDI9oIOj
         Wepg==
X-Gm-Message-State: AOAM531G3aO0KlV1SwtylTMDs2k4CUWxD69sxtFAClc5yDk8sDiwOdJV
        iSKqx+k+5DsnKLtIw4J/FHw=
X-Google-Smtp-Source: ABdhPJzD2fejCDcNpbmTVteUssbrr9xIm3aUyCk/lGB8HRuvUkpYOk0RzgOFN0nhOZt8HQ/3m78Z+A==
X-Received: by 2002:a5d:6a8b:: with SMTP id s11mr33418683wru.88.1624971321866;
        Tue, 29 Jun 2021 05:55:21 -0700 (PDT)
Received: from liuwe-devbox-debian-v2 ([51.145.34.42])
        by smtp.gmail.com with ESMTPSA id p5sm19411722wrd.25.2021.06.29.05.55.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Jun 2021 05:55:21 -0700 (PDT)
Date:   Tue, 29 Jun 2021 12:55:19 +0000
From:   Wei Liu <wei.liu@kernel.org>
To:     Vitaly Kuznetsov <vkuznets@redhat.com>
Cc:     Vineeth Pillai <viremana@linux.microsoft.com>,
        Nuno Das Neves <nunodasneves@linux.microsoft.com>,
        Wei Liu <wei.liu@kernel.org>,
        Sunil Muthuswamy <sunilmut@microsoft.com>,
        Michael Kelley <mikelley@microsoft.com>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, linux-hyperv@vger.kernel.org
Subject: Re: [PATCH 06/17] mshv: SynIC port and connection hypercalls
Message-ID: <20210629125519.27vv3afwhjoobekf@liuwe-devbox-debian-v2>
References: <cover.1622654100.git.viremana@linux.microsoft.com>
 <3125953aae8e7950a6da4c311ef163b79d6fb6b3.1622654100.git.viremana@linux.microsoft.com>
 <87v96lykrz.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87v96lykrz.fsf@vitty.brq.redhat.com>
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Thu, Jun 10, 2021 at 02:19:28PM +0200, Vitaly Kuznetsov wrote:
> Vineeth Pillai <viremana@linux.microsoft.com> writes:
> 
> > Hyper-V enables inter-partition communication through the port and
> > connection constructs. More details about ports and connections in
> > TLFS chapter 11.
> >
> > Implement hypercalls related to ports and connections for enabling
> > inter-partiion communication.
> >
> > Signed-off-by: Vineeth Pillai <viremana@linux.microsoft.com>
> > ---
> >  drivers/hv/hv_call.c                   | 161 +++++++++++++++++++++++++
> >  drivers/hv/mshv.h                      |  12 ++
> >  include/asm-generic/hyperv-tlfs.h      |  55 +++++++++
> >  include/linux/hyperv.h                 |   9 --
> >  include/uapi/asm-generic/hyperv-tlfs.h |  76 ++++++++++++
> >  5 files changed, 304 insertions(+), 9 deletions(-)
> >
> > diff --git a/drivers/hv/hv_call.c b/drivers/hv/hv_call.c
> > index 025d4e2b892f..57db3a8ac94a 100644
> > --- a/drivers/hv/hv_call.c
> > +++ b/drivers/hv/hv_call.c
> > @@ -742,3 +742,164 @@ int hv_call_translate_virtual_address(
> >  	return hv_status_to_errno(status);
> >  }
> >  
> > +
> > +int
> > +hv_call_create_port(u64 port_partition_id, union hv_port_id port_id,
> > +		    u64 connection_partition_id,
> > +		    struct hv_port_info *port_info,
> > +		    u8 port_vtl, u8 min_connection_vtl, int node)
> > +{
> > +	struct hv_create_port *input;
> > +	unsigned long flags;
> > +	int ret = 0;
> > +	int status;
> > +
> > +	do {
> > +		local_irq_save(flags);
> > +		input = (struct hv_create_port *)(*this_cpu_ptr(
> > +				hyperv_pcpu_input_arg));
> > +		memset(input, 0, sizeof(*input));
> > +
> > +		input->port_partition_id = port_partition_id;
> > +		input->port_id = port_id;
> > +		input->connection_partition_id = connection_partition_id;
> > +		input->port_info = *port_info;
> > +		input->port_vtl = port_vtl;
> > +		input->min_connection_vtl = min_connection_vtl;
> > +		input->proximity_domain_info =
> > +			numa_node_to_proximity_domain_info(node);
> > +		status = hv_do_hypercall(HVCALL_CREATE_PORT, input,
> > +					NULL) & HV_HYPERCALL_RESULT_MASK;
> > +		local_irq_restore(flags);
> > +		if (status == HV_STATUS_SUCCESS)
> > +			break;
> > +
> > +		if (status != HV_STATUS_INSUFFICIENT_MEMORY) {
> > +			pr_err("%s: %s\n",
> > +			       __func__, hv_status_to_string(status));
> > +			ret = -hv_status_to_errno(status);
> 
> In Nuno's "x86/hyperv: convert hyperv statuses to linux error codes"
> patch, hv_status_to_errno() already returns negatives:

Yes, this needs to be fixed otherwise one of the following patch has the
error handling check reversed.

Wei.
