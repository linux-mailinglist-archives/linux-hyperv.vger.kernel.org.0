Return-Path: <linux-hyperv+bounces-71-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EEC07A04BC
	for <lists+linux-hyperv@lfdr.de>; Thu, 14 Sep 2023 15:01:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E4E58B2129A
	for <lists+linux-hyperv@lfdr.de>; Thu, 14 Sep 2023 13:01:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 618FA24211;
	Thu, 14 Sep 2023 13:01:40 +0000 (UTC)
X-Original-To: linux-hyperv@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 550F6241E0
	for <linux-hyperv@vger.kernel.org>; Thu, 14 Sep 2023 13:01:40 +0000 (UTC)
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDC591FD0
	for <linux-hyperv@vger.kernel.org>; Thu, 14 Sep 2023 06:01:38 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id 5b1f17b1804b1-401d10e3e54so9728685e9.2
        for <linux-hyperv@vger.kernel.org>; Thu, 14 Sep 2023 06:01:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=citrix.com; s=google; t=1694696497; x=1695301297; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:references:cc:to
         :content-language:subject:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=ddiGkE6j5Yqjx2YChUyXAKUMjOfVYGR2wU1BDa/uOVM=;
        b=R/7QQUfIOihU7dGQ6BLubDNlHg4kFo2L3RePq6XZ9UzkbShQ72beoYkykdPtNO9ojO
         hOi7dAks7mgoG/wxJR4kvEWG1ZNr3QcSdYw4xWD4k3oDGO+9xgWVlnqXDnDxVQPu7jx3
         FvCAIOzKqJjiMBjCK7g4R7Ctiafan+9onbcyE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694696497; x=1695301297;
        h=content-transfer-encoding:in-reply-to:references:cc:to
         :content-language:subject:from:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ddiGkE6j5Yqjx2YChUyXAKUMjOfVYGR2wU1BDa/uOVM=;
        b=TxCfMwp/c1GnYG8eflp75wT8MrNfyWOuGIFRgmt+wIXupMGGXSBp/3+Gc7mw1vlYBv
         81zLLkXhSldBckH1y6fC5uYZD26O64r+ibHpGQla3pZhLlPdWraDq3d6PHXTiRjYEsVj
         pWedd9RqEoA+IMaPXwpwlmrEcrcaMLVtpTSI6Oa4KwNhaf2duQpldI761I5h4ryYBa9k
         ZgtrMiZxAe4kSXA0nz13mdnJ9qWwHe8PTkM5808Hy3dfVHjZAlQwrRJLIojlhP59+xq4
         3DG6SghB/f8Ug8pEqYw3J8Ax6bk+eD+4G8fIKAZ2PcKL79ey0zx9JPkK3qCLY4wzYHUJ
         9acQ==
X-Gm-Message-State: AOJu0YxXrhY514TX3qw3SE/Vbur2tVrvTXQqcf4H4kJmnmrZdsafS+zy
	wayBRzKV2sSQa6L72qjF3yjzRg==
X-Google-Smtp-Source: AGHT+IGu9ZokynanEidxo6b4ugwjHDqKzn9EMgeKgnKUXWugWLtEAMgf7RA8IhMPo5oq1q9TPG+E9Q==
X-Received: by 2002:a05:600c:b5a:b0:401:eb0:a98d with SMTP id k26-20020a05600c0b5a00b004010eb0a98dmr4538194wmr.24.1694696496369;
        Thu, 14 Sep 2023 06:01:36 -0700 (PDT)
Received: from [10.80.67.28] (default-46-102-197-194.interdsl.co.uk. [46.102.197.194])
        by smtp.gmail.com with ESMTPSA id c20-20020a7bc854000000b003fee6f027c7sm4769165wml.19.2023.09.14.06.01.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Sep 2023 06:01:35 -0700 (PDT)
Message-ID: <b894ba89-27b2-88a9-6adf-7d53e2c51c02@citrix.com>
Date: Thu, 14 Sep 2023 14:01:35 +0100
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
From: andrew.cooper3@citrix.com
Subject: Re: [PATCH v10 03/38] x86/msr: Add the WRMSRNS instruction support
Content-Language: en-GB
To: Juergen Gross <jgross@suse.com>, Xin Li <xin3.li@intel.com>,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-edac@vger.kernel.org, linux-hyperv@vger.kernel.org,
 kvm@vger.kernel.org, xen-devel@lists.xenproject.org
Cc: tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
 dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com, luto@kernel.org,
 pbonzini@redhat.com, seanjc@google.com, peterz@infradead.org,
 ravi.v.shankar@intel.com, mhiramat@kernel.org, jiangshanlai@gmail.com
References: <20230914044805.301390-1-xin3.li@intel.com>
 <20230914044805.301390-4-xin3.li@intel.com>
 <48d312f4-50cd-468d-af70-51314796b0d8@suse.com>
In-Reply-To: <48d312f4-50cd-468d-af70-51314796b0d8@suse.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 14/09/2023 7:02 am, Juergen Gross wrote:
> On 14.09.23 06:47, Xin Li wrote:
>> Add an always inline API __wrmsrns() to embed the WRMSRNS instruction
>> into the code.
>>
>> Tested-by: Shan Kang <shan.kang@intel.com>
>> Signed-off-by: Xin Li <xin3.li@intel.com>
>
> In order to avoid having to add paravirt support for WRMSRNS I think
> xen_init_capabilities() should gain:
>
> +    setup_clear_cpu_cap(X86_FEATURE_WRMSRNS);

Xen PV guests will never ever see WRMSRNS.  Operating in CPL3, they have
no possible way of adjusting an MSR which isn't serialising, because
even the hypercall forms are serialising.

Xen only exposes the bit for HVM guests.

~Andrew

