Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5309227AA37
	for <lists+linux-hyperv@lfdr.de>; Mon, 28 Sep 2020 11:07:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726534AbgI1JHq (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 28 Sep 2020 05:07:46 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:34694 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726500AbgI1JHq (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 28 Sep 2020 05:07:46 -0400
Received: by mail-wr1-f67.google.com with SMTP id t10so391283wrv.1;
        Mon, 28 Sep 2020 02:07:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=qzvbdMgwoVoLCV4C+38jPCHClAMjCEBSggnue6sORug=;
        b=CXoWIYXJCUGgRGvc61My65MN40cDDV65ZJ8NWyJKvFiZln7U4QyMv3RBmTG8aYMQpA
         U8QANLTQPqcNtZfNQjUdMGJW7SMjoMnszWRM1iQgT0IfV/tl2RiyJTcyq90pPhhKoAjl
         jRv6qZyYOvaM8DlRaF2oGsHo3IQylPXflxRgUbxTpOQaVQ4PYDndb/8HL+I6UvR/eNOl
         M24yJm/o1M/9KqYqL+eo6o5gM/yLx+RoLob6snHhv3b3hfGwDaErwufLvqDRJc0FUTUm
         7RdZv/82/95wjToClTwfpq/TE3ZO4rkynfSJP4PoN8+EP8lW4Py4ih+6c3E3fo0LsjOR
         zCTw==
X-Gm-Message-State: AOAM532X2F3YLLd9/6VXomEhExCHTez/kGp/8HElsv2LBKkw7KobpiJi
        ef9cBS6Vs97d/57CRHZcH64=
X-Google-Smtp-Source: ABdhPJwuE5MWb+vye6CbihbqmpOf7xcESu4nA0YyqVV2RIVNqBiUHLXruYiTrkKZ106KtoFELoxoVA==
X-Received: by 2002:adf:fa02:: with SMTP id m2mr505869wrr.273.1601284064447;
        Mon, 28 Sep 2020 02:07:44 -0700 (PDT)
Received: from liuwe-devbox-debian-v2 ([51.145.34.42])
        by smtp.gmail.com with ESMTPSA id a5sm603877wrp.37.2020.09.28.02.07.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Sep 2020 02:07:44 -0700 (PDT)
Date:   Mon, 28 Sep 2020 09:07:42 +0000
From:   Wei Liu <wei.liu@kernel.org>
To:     Vitaly Kuznetsov <vkuznets@redhat.com>
Cc:     Mohammed Gamal <mgamal@redhat.com>, linux-hyperv@vger.kernel.org,
        linux-kernel@vger.kernel.org, mikelley@microsoft.com,
        Tianyu.Lan@microsoft.com, kys@microsoft.com,
        haiyangz@microsoft.com, wei.liu@kernel.org
Subject: Re: [PATCH] hv: clocksource: Add notrace attribute to
 read_hv_sched_clock_*() functions
Message-ID: <20200928090742.6qrpon2cbb5dz7rc@liuwe-devbox-debian-v2>
References: <20200924151117.767442-1-mgamal@redhat.com>
 <87pn6bchkc.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87pn6bchkc.fsf@vitty.brq.redhat.com>
User-Agent: NeoMutt/20180716
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Thu, Sep 24, 2020 at 05:36:51PM +0200, Vitaly Kuznetsov wrote:
> Mohammed Gamal <mgamal@redhat.com> writes:
> 
[...]
> 
> Obviously we're seeing a recursion, we can trim this log a bit.

I've trimmed the stack trace a bit.

> 
> >
> > Setting the notrace attribute for read_hv_sched_clock_msr() and
> > read_hv_sched_clock_tsc() fixes it

Also added a period at the end.

> >
> > Fixes: bd00cd52d5be ("clocksource/drivers/hyperv: Add Hyper-V specific
> > sched clock function")
> > Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
> 
> Rather 'Suggested-by:' but not a big deal.
> 

And changed this too.

This patch is now in hyperv-next. Thanks.

Wei.
