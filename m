Return-Path: <linux-hyperv+bounces-134-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C4E9D7A8AEB
	for <lists+linux-hyperv@lfdr.de>; Wed, 20 Sep 2023 19:55:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7E67A2816AA
	for <lists+linux-hyperv@lfdr.de>; Wed, 20 Sep 2023 17:55:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8299E3FB0B;
	Wed, 20 Sep 2023 17:55:05 +0000 (UTC)
X-Original-To: linux-hyperv@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26AEA1A5A8
	for <linux-hyperv@vger.kernel.org>; Wed, 20 Sep 2023 17:55:04 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBD0CDE
	for <linux-hyperv@vger.kernel.org>; Wed, 20 Sep 2023 10:55:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1695232502;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=h5xYFinNZipHsHGmHUqZFR1epFlz8wPv/8ryGu1Ybe8=;
	b=RUdhs6NCZArzN5tmhbMls6Ei3DrhYhtrd+xrjh63tN8PIUL4cBIEIXXGCVrPQuBFu8t1/+
	3rtTKT2y5jXsUDpxtoaoLBmkvxBoXJ4qW7niW+XLJNbyFM0EbD9ElnFHW1A7Oq7aOgDjOM
	816KRapTtghDKkr5frY7YmJNF3f5W/4=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-94-Es1t1rQENiuvK6Xx9XmTng-1; Wed, 20 Sep 2023 13:55:00 -0400
X-MC-Unique: Es1t1rQENiuvK6Xx9XmTng-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4011fa32e99so741395e9.0
        for <linux-hyperv@vger.kernel.org>; Wed, 20 Sep 2023 10:54:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695232498; x=1695837298;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=h5xYFinNZipHsHGmHUqZFR1epFlz8wPv/8ryGu1Ybe8=;
        b=k5lHN8kqCyQcT0ldqqD9guFsVlzkK+nsj5mDTGPhFSR90fZfrtUBtB7XlQpbN/QB/5
         ZlKjlJXWu69MbvlVA+MZJFl6WoJ3vFKsgsMI31pZ5bCPAdZ8B+GdptnFEDE1bkck8jVO
         4I84Vy6KLsPdouKmKYC6dn+BtFtZXoNtVrRp3Mvp8H2MBi5rXc3XazfCQQspll+a8SET
         BLcKpFxqSuj7sVTuNnJRRdimZg8ztObO9Xt9Wom5MmI4RoWab/loarSNFSNRTssCUova
         81rixnE9V3Thr9/Q5lTzuxoXgdXBnhzv5HjI3Eukm/N9SxK8w4oQwRqTPimsbSp3j6Dz
         dPJg==
X-Gm-Message-State: AOJu0YyiidS4cyTxc8XyuHEX2KEkEXhgwOHt+Qn8a1sVqOjNZyrRX+q2
	2jzc9hv19qR7UqjqI/nJTQfF01cxLf+H9lLzEsdfLDeLWnv8K6b853+liYbep1HdV+v8kc2BYQd
	8fiN0v1EwLtTy0D+YSoUuoMZa
X-Received: by 2002:a7b:ce88:0:b0:400:57d1:4910 with SMTP id q8-20020a7bce88000000b0040057d14910mr3302433wmj.17.1695232497847;
        Wed, 20 Sep 2023 10:54:57 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHnadv5Rrllbv+1DebvWmStjUdr36msQ4bItIjpfqmG73HPxauN1Zj4NCrq5iVMGFuoky2thA==
X-Received: by 2002:a7b:ce88:0:b0:400:57d1:4910 with SMTP id q8-20020a7bce88000000b0040057d14910mr3302418wmj.17.1695232497523;
        Wed, 20 Sep 2023 10:54:57 -0700 (PDT)
Received: from ?IPV6:2001:b07:6468:f312:9af8:e5f5:7516:fa89? ([2001:b07:6468:f312:9af8:e5f5:7516:fa89])
        by smtp.googlemail.com with ESMTPSA id g7-20020a05600c310700b003fe15ac0934sm1501378wmo.1.2023.09.20.10.54.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Sep 2023 10:54:54 -0700 (PDT)
Message-ID: <facdf62c-d0b4-597d-a85d-5772ecaa2b86@redhat.com>
Date: Wed, 20 Sep 2023 19:54:48 +0200
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v10 33/38] x86/entry: Add fred_entry_from_kvm() for VMX to
 handle IRQ/NMI
To: Xin Li <xin3.li@intel.com>, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-edac@vger.kernel.org,
 linux-hyperv@vger.kernel.org, kvm@vger.kernel.org,
 xen-devel@lists.xenproject.org
Cc: tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
 dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com, luto@kernel.org,
 seanjc@google.com, peterz@infradead.org, jgross@suse.com,
 ravi.v.shankar@intel.com, mhiramat@kernel.org, andrew.cooper3@citrix.com,
 jiangshanlai@gmail.com
References: <20230914044805.301390-1-xin3.li@intel.com>
 <20230914044805.301390-34-xin3.li@intel.com>
Content-Language: en-US
From: Paolo Bonzini <pbonzini@redhat.com>
In-Reply-To: <20230914044805.301390-34-xin3.li@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 9/14/23 06:48, Xin Li wrote:
> +	/*
> +	 * Don't check the FRED stack level, the call stack leading to this
> +	 * helper is effectively constant and shallow (relatively speaking).

It's more that we don't need to protect from reentrancy.  The external 
interrupt uses stack level 0 so no adjustment would be needed anyway, 
and NMI does not use an IST even in the non-FRED case.

> +	 * Emulate the FRED-defined redzone and stack alignment.
> +	 */
> +	sub $(FRED_CONFIG_REDZONE_AMOUNT << 6), %rsp
> +	and $FRED_STACK_FRAME_RSP_MASK, %rsp


