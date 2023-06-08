Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51FE1727A90
	for <lists+linux-hyperv@lfdr.de>; Thu,  8 Jun 2023 10:55:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235540AbjFHIzv (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 8 Jun 2023 04:55:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235485AbjFHIzt (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 8 Jun 2023 04:55:49 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1491E61
        for <linux-hyperv@vger.kernel.org>; Thu,  8 Jun 2023 01:55:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1686214501;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=hy3A1Ua9yZiMcI9cw8LBoikuGcbbLc5s+RNFFyFQvUg=;
        b=EMbEYcMlFi5dMOZRv4MZrMDj4RS9Bmbzl3qZonW/8IwoTqKZ+5QhqXeSGDohZO4BO91dp+
        xFS192wBIKhhYOH42pe3E60ujqBEFB9UFCRcHAxQq8M2fwoaIMSpwykXXBwEF4PF201RN4
        QwOBBbkO+komWu0oTIeDhp9Hb15QSPI=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-175-KUIi86mGMU2SrMbzrSgvbg-1; Thu, 08 Jun 2023 04:54:59 -0400
X-MC-Unique: KUIi86mGMU2SrMbzrSgvbg-1
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-75d4e8bf725so50965485a.0
        for <linux-hyperv@vger.kernel.org>; Thu, 08 Jun 2023 01:54:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686214499; x=1688806499;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hy3A1Ua9yZiMcI9cw8LBoikuGcbbLc5s+RNFFyFQvUg=;
        b=VKUYq9ZAfEqAKP2KwOQtStdqqrG3L02WXCO4bgYzvpz/SIlyNHaB2l8ZyJ4mt6e/dH
         ACMN1Xg76Ywpc5Dyff4uVUPrYJruvfyaOUzluYuRrj0qYLAWo+3mS1pzZlRKOo+FJFZD
         +gczORFp/tSMGKf0tiEjDC9e8xG9LiO+eQuPPLmSLm5KLTxgdpXr7Y47BGEm/sbnZkLL
         8QIJT5MxUb/yQ9uWUG2rcwtXYsgiCa/4jYjKT3/UsgZWclgvBYTuHIjJpasLDdj9Jp0p
         kQVhL9m6U/MLTz43kHAlNBe/7Y8WQOtaelSuXWczlHGr824wYubLwWivI2msMixPXRVn
         CuqQ==
X-Gm-Message-State: AC+VfDwAHP0yJW+IZ4DW8Wvqq73C3tL+192zEQGqs2AYiCchsHURTaLG
        KXBVyPuJVrj5RPNaRYmlLYrHvcP0CKG5JTNUjYEmk4O4jCCTlVZPPaeIgrUAbKd3FUGX2pvFDBk
        mYuertFLV08YKITR2ak2Of0Q8
X-Received: by 2002:a05:620a:27cc:b0:75d:5803:a20 with SMTP id i12-20020a05620a27cc00b0075d58030a20mr4694392qkp.68.1686214499113;
        Thu, 08 Jun 2023 01:54:59 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ60oKmeuw06BMJkmeUPBP5oGcgJHw6hr4LDQE1HQbUBnKu5b4VIu+yrq+1gpDjw9S/JAlbteQ==
X-Received: by 2002:a05:620a:27cc:b0:75d:5803:a20 with SMTP id i12-20020a05620a27cc00b0075d58030a20mr4694360qkp.68.1686214497800;
        Thu, 08 Jun 2023 01:54:57 -0700 (PDT)
Received: from fedora (g2.ign.cz. [91.219.240.8])
        by smtp.gmail.com with ESMTPSA id pa29-20020a05620a831d00b0074d3233487dsm182509qkn.114.2023.06.08.01.54.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Jun 2023 01:54:57 -0700 (PDT)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Tianyu Lan <ltykernel@gmail.com>, kys@microsoft.com,
        haiyangz@microsoft.com, wei.liu@kernel.org, decui@microsoft.com,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
        daniel.lezcano@linaro.org, arnd@arndb.de,
        michael.h.kelley@microsoft.com
Cc:     Tianyu Lan <tiala@microsoft.com>, linux-arch@vger.kernel.org,
        linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/9] drivers: hv: Mark shared pages unencrypted in
 SEV-SNP enlightened guest
In-Reply-To: <2803e5d6-58bc-57f1-0721-226333238883@gmail.com>
References: <20230601151624.1757616-1-ltykernel@gmail.com>
 <20230601151624.1757616-5-ltykernel@gmail.com> <87zg5ejchp.fsf@redhat.com>
 <2803e5d6-58bc-57f1-0721-226333238883@gmail.com>
Date:   Thu, 08 Jun 2023 10:54:53 +0200
Message-ID: <87cz26jpuq.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Tianyu Lan <ltykernel@gmail.com> writes:

> On 6/5/2023 8:54 PM, Vitaly Kuznetsov wrote:
>>> @@ -402,7 +417,14 @@ int hv_common_cpu_die(unsigned int cpu)
>>>   
>>>   	local_irq_restore(flags);
>>>   
>>> -	kfree(mem);
>>> +	if (hv_isolation_type_en_snp()) {
>>> +		ret = set_memory_encrypted((unsigned long)mem, pgcount);
>>> +		if (ret)
>>> +			pr_warn("Hyper-V: Failed to encrypt input arg on cpu%d: %d\n",
>>> +				cpu, ret);
>>> +		/* It's unsafe to free 'mem'. */
>>> +		return 0;
>> Why is it unsafe to free 'mem' if ret == 0? Also, why don't we want to
>> proparate non-zero 'ret' from here to fail CPU offlining?
>> 
>
> Based on Michael's patch the mem will not be freed during cpu offline.
> https://lwn.net/ml/linux-kernel/87cz2j5zrc.fsf@redhat.com/
> So I think it's unnessary to encrypt the mem again here.

Good, you can probably include Michael's patch in your next submission
then (unless it gets merged before that).

-- 
Vitaly

