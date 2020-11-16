Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 237482B4A2B
	for <lists+linux-hyperv@lfdr.de>; Mon, 16 Nov 2020 17:01:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730773AbgKPP6l (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 16 Nov 2020 10:58:41 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:40147 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730176AbgKPP6l (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 16 Nov 2020 10:58:41 -0500
Received: by mail-wm1-f66.google.com with SMTP id a3so24050798wmb.5;
        Mon, 16 Nov 2020 07:58:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=1oQ4B5llrsrQYfFPkW6U5dEnNGacSaiQC37uZPELFqA=;
        b=prtE5XAozMfaPnlX+lHnyR8t/gm/GPRGf8S0ZG4ftKiNVBX1k67qua9zc5ZbQkl04T
         TxvJ6EWmd7l5vqaNnIpRb4nRU/viSOMNLugU4mq/77cdgDVi1zROI5k8CWSZBBJexFUx
         m7K0fuIogu5+9qFtTF/8Mq2uMW4DgBEKFko5b6gDi1GvILGDXowieKwLRizHJlw4c50Y
         e4q1rniojHTRS7mhE5ocetqIehxftzl+HUFj+QF/zGWzDxES+WqCLO3OvNG+NlJ8An0E
         fA+1LB1HyNAZfks/rzSlwH1+ePYyb+2bNOdrucxGiEh2kJ6r60AVIrh3CT7EvViYDYHp
         T6dg==
X-Gm-Message-State: AOAM533nVZ5xv/LfU+1CU/d1BGaB1wJbU8hNOntoDb+bKUgfCASXogaH
        NSkoqRqohICnuhsKB/uoWCQ=
X-Google-Smtp-Source: ABdhPJw7YkD9JjJB14PlrAKVTYqwsaNVm0V52bkCn1J4G3Zk0WntP3BmPHio9ucMKb8a/tAvL0C40A==
X-Received: by 2002:a1c:c2c3:: with SMTP id s186mr16619148wmf.160.1605542319664;
        Mon, 16 Nov 2020 07:58:39 -0800 (PST)
Received: from liuwe-devbox-debian-v2 ([51.145.34.42])
        by smtp.gmail.com with ESMTPSA id d63sm20354449wmd.12.2020.11.16.07.58.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2020 07:58:38 -0800 (PST)
Date:   Mon, 16 Nov 2020 15:58:37 +0000
From:   Wei Liu <wei.liu@kernel.org>
To:     Matheus Castello <matheus@castello.eng.br>
Cc:     kys@microsoft.com, haiyangz@microsoft.com, sthemmin@microsoft.com,
        wei.liu@kernel.org, sashal@kernel.org, Tianyu.Lan@microsoft.com,
        decui@microsoft.com, mikelley@microsoft.com,
        sunilmut@microsoft.com, linux-hyperv@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/6] drivers: hv: vmbus: Fix unnecessary OOM_MESSAGE
Message-ID: <20201116155837.7mzaijtfpvmrnkve@liuwe-devbox-debian-v2>
References: <20201115195734.8338-1-matheus@castello.eng.br>
 <20201115195734.8338-6-matheus@castello.eng.br>
 <20201116112148.xfajvts4gtoibs65@liuwe-devbox-debian-v2>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201116112148.xfajvts4gtoibs65@liuwe-devbox-debian-v2>
User-Agent: NeoMutt/20180716
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Mon, Nov 16, 2020 at 11:21:48AM +0000, Wei Liu wrote:
> On Sun, Nov 15, 2020 at 04:57:33PM -0300, Matheus Castello wrote:
> > Fixed checkpatch warning: Possible unnecessary 'out of memory' message
> > checkpatch(OOM_MESSAGE)
> > 
> > Signed-off-by: Matheus Castello <matheus@castello.eng.br>
> > ---
> >  drivers/hv/vmbus_drv.c | 4 +---
> >  1 file changed, 1 insertion(+), 3 deletions(-)
> > 
> > diff --git a/drivers/hv/vmbus_drv.c b/drivers/hv/vmbus_drv.c
> > index 09d8236a51cf..774b88dd0e15 100644
> > --- a/drivers/hv/vmbus_drv.c
> > +++ b/drivers/hv/vmbus_drv.c
> > @@ -1989,10 +1989,8 @@ struct hv_device *vmbus_device_create(const guid_t *type,
> >  	struct hv_device *child_device_obj;
> > 
> >  	child_device_obj = kzalloc(sizeof(struct hv_device), GFP_KERNEL);
> > -	if (!child_device_obj) {
> > -		pr_err("Unable to allocate device object for child device\n");
> > +	if (!child_device_obj)
> 
> The generic OOM message would give you a stack dump but not as specific
> / clear as the message you deleted.
> 
> Also, the original intent of this check was to check for things like
> 
>     printk("Out of memory");
> 
> which was clearly redundant. The message we print here is not that.
> 
> See https://lkml.org/lkml/2014/6/10/382 .
> 

In case my message is not clear, I think this pr_err should stay. ;-)

Wei.
