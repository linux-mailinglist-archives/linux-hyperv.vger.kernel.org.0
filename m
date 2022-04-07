Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 846CD4F7256
	for <lists+linux-hyperv@lfdr.de>; Thu,  7 Apr 2022 04:54:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233159AbiDGC4d (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 6 Apr 2022 22:56:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbiDGC4d (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 6 Apr 2022 22:56:33 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7AA1114FC0;
        Wed,  6 Apr 2022 19:54:34 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id dr20so7985805ejc.6;
        Wed, 06 Apr 2022 19:54:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=M7QuqGXibgOQy0pEz/HDPB8sGsU+FPSqjY3hnu+QJvQ=;
        b=cJFr7C/2zw4qQ/ZJ/S2oEtd79Lcy2POVWiMDtiRaMp127fHQ0OCoLy+Vt38uAjTlIL
         ihktq7YDKs5Bc0pn2w867AUjFkkV79Mwa0iSIoeRS/4GOyKppugMW85KUL8BEQfoSSAg
         jgmE6pYABo4IwQfwWJpaOUXUyWMAwnC0xOo50LHLNDKFQesP/WQw8XHfrsMd2QzgNkjd
         x+sv3gkIxJHURPKST4XwjPkLuXfgRq5ZzPxpAwPmAHgjZRQ13+4tCCjA/bd1vAbJhdvU
         5zB+8T6h4cx9UpXf5eguvdUUkgOFSqroxs9Q+x2otFDH6VwH/lg4bUz5tXoxsnJVB6cL
         K6qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=M7QuqGXibgOQy0pEz/HDPB8sGsU+FPSqjY3hnu+QJvQ=;
        b=ez18im5gNOWamp+pPz55hQLTA6wrATBzjNnSsaga6p0GDswz5W2DuGZJc1a6cPpT4O
         spi3oY7MRA6sTrNT5xFJVp4NMQ4eisGu2WNj8DymJY0d+UJNZlz7K0Fq1zd91RULTaFb
         QLrlMuf0euRLTulOnjGgbdNR5zl2rcozXzGYgVwoNKYAYeH2RYzT56Oms2C3FOTlcmOH
         taWLCxDoyJJprNeS59SR+fTBfd7vYVS1VSKxySzhQruHd640jZOyLOr+ZOviZWTNZxr5
         5dP7CZpTATJoxvRD3z2KQoKWBasNF5KTSEofHyFBrtc/lV5zKg2XIdnQxPumj6IeyNlC
         iWUQ==
X-Gm-Message-State: AOAM530jTCWW5+aSS5cyLCPjiX953olkGG2B/TZX4HvNjvYKYfespnIo
        4Jupiz1D+fyLOb3vh/64d1bUskgzhLo=
X-Google-Smtp-Source: ABdhPJyMneW8CmB/Y7VLqcqrpNOq+Sj2iQlxd7q/+ro1SXTmN3yptfKqg8/lskBjKh65YWmv0toRyw==
X-Received: by 2002:a17:906:b157:b0:6d0:9f3b:a6aa with SMTP id bt23-20020a170906b15700b006d09f3ba6aamr11135532ejb.365.1649300073244;
        Wed, 06 Apr 2022 19:54:33 -0700 (PDT)
Received: from anparri (host-87-11-75-174.retail.telecomitalia.it. [87.11.75.174])
        by smtp.gmail.com with ESMTPSA id qp27-20020a170907207b00b006e66a4e924bsm5707995ejb.201.2022.04.06.19.54.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Apr 2022 19:54:32 -0700 (PDT)
Date:   Thu, 7 Apr 2022 04:54:25 +0200
From:   Andrea Parri <parri.andrea@gmail.com>
To:     KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
        Michael Kelley <mikelley@microsoft.com>,
        Wei Hu <weh@microsoft.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Wilczynski <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc:     linux-hyperv@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 1/4] Drivers: hv: vmbus: Remove special code for
 unsolicited messages
Message-ID: <20220407025425.GA32474@anparri>
References: <20220328144244.100228-1-parri.andrea@gmail.com>
 <20220328144244.100228-2-parri.andrea@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220328144244.100228-2-parri.andrea@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Mon, Mar 28, 2022 at 04:42:41PM +0200, Andrea Parri (Microsoft) wrote:
> vmbus_requestor has included code for handling unsolicited messages
> since its introduction with commit e8b7db38449ac ("Drivers: hv: vmbus:
> Add vmbus_requestor data structure for VMBus hardening"); such code was
> motivated by the early use of vmbus_requestor from storvsc.  Since
> storvsc moved to a tag-based mechanism to generate/retrieve request IDs
> with commit bf5fd8cae3c8f ("scsi: storvsc: Use blk_mq_unique_tag() to
> generate requestIDs"), the special handling of unsolicited messages in
> vmbus_requestor is not useful and can be removed.

As it turns out, this is not quite right.  In particular...


> @@ -1243,11 +1243,7 @@ u64 vmbus_next_request_id(struct vmbus_channel *channel, u64 rqst_addr)
>  
>  	spin_unlock_irqrestore(&rqstor->req_lock, flags);
>  
> -	/*
> -	 * Cannot return an ID of 0, which is reserved for an unsolicited
> -	 * message from Hyper-V.
> -	 */
> -	return current_id + 1;
> +	return current_id;

Hyper-V treats requests with ID of 0 as "non-transactional" and it does
not respond to such requests.


> @@ -1268,15 +1264,8 @@ u64 vmbus_request_addr(struct vmbus_channel *channel, u64 trans_id)
>  	if (!channel->rqstor_size)
>  		return VMBUS_NO_RQSTOR;
>  
> -	/* Hyper-V can send an unsolicited message with ID of 0 */
> -	if (!trans_id)
> -		return trans_id;

This remains problematic: I will elaborate and propose some solution in
the next iteration (to be sent shortly).

Thanks,
  Andrea

> -
>  	spin_lock_irqsave(&rqstor->req_lock, flags);
>  
> -	/* Data corresponding to trans_id is stored at trans_id - 1 */
> -	trans_id--;
> -
>  	/* Invalid trans_id */
>  	if (trans_id >= rqstor->size || !test_bit(trans_id, rqstor->req_bitmap)) {
>  		spin_unlock_irqrestore(&rqstor->req_lock, flags);
