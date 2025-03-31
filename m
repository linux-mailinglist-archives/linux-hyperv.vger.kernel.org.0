Return-Path: <linux-hyperv+bounces-4756-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EBCE8A77049
	for <lists+linux-hyperv@lfdr.de>; Mon, 31 Mar 2025 23:46:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7A8C3165348
	for <lists+linux-hyperv@lfdr.de>; Mon, 31 Mar 2025 21:46:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F419D21660F;
	Mon, 31 Mar 2025 21:45:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=citrix.com header.i=@citrix.com header.b="hYn56Aiy"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2797021B9FC
	for <linux-hyperv@vger.kernel.org>; Mon, 31 Mar 2025 21:45:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743457550; cv=none; b=pGFjKDKuUj4SyXbmF9t+ceCNscj1eNKQ1yGurgPvTYZupOc+0XCPUdVfFUzka0q+ndk4H9Yiw+eN5ApGjAOcnPLrzQErt5iz4jDxuQDqzUVFFA6PkcrkUA2eN9pJa74nOhDipJqZedYSYzDGmaLgWnXcTt9Rho2+HTfJnzcc5lg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743457550; c=relaxed/simple;
	bh=5Idp/e1CX6KvP46H/IAQSzNlFEJZHJleXvMU+UGEsKY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MguGCs6JeHSZbLa3Eb4i7R4NVF090rw2bvN2ciL2F53ja8o8ep85vMrW2PKaRDUrJBjEsWSKqXtD7RuwL4ZbSpy4Wpwvo8fd8Cm4xtDSlrLXDuoFRqJmxg+uJP4DKUAuJqUl+NM2Db/FS8brrSUt6/pvGw3ebmck1KZqdbrTMyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=citrix.com; spf=pass smtp.mailfrom=cloud.com; dkim=pass (1024-bit key) header.d=citrix.com header.i=@citrix.com header.b=hYn56Aiy; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=citrix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloud.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-43cfe63c592so49814155e9.2
        for <linux-hyperv@vger.kernel.org>; Mon, 31 Mar 2025 14:45:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=citrix.com; s=google; t=1743457546; x=1744062346; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=mlR2/wtGl27sbeVJieM7lcGEWWY98/3HknehfYFQ3N0=;
        b=hYn56Aiyv02GdoPo4uBxbrlSGBdGlo4UgbwTUBDbw47O/0LcemMuI87AokxOcGJGdn
         0e39lV85rffVM8FNIbbgBJ69W9BbIL4mmodsu36fr9Z3QVXKnItvyCzxM8ajdlDib5Z4
         oBoYsA+pEJuUCgXPLyAQ3Sgu03XmGCTzJ/qNc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743457546; x=1744062346;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mlR2/wtGl27sbeVJieM7lcGEWWY98/3HknehfYFQ3N0=;
        b=J3fb2asx8CR/q7yRQ9Q322ZYESdAlexfZo0TUEohR9nvbVNyJQapGjCZ8pKZjnTQ/a
         geytMEIbXihJDPsIbEnTL8WIs481sxTQee1wsCCMjxXGn78BSXVk/GEVUn1JPCANXEk8
         Fx1J3Ltllxah+L5i2yO9COwqU7uXGZ0W3a/sHCOUfPsPMPuTxVflbmYEo8HXfb7+4EHz
         olUeS6n2QW9oFxMiNqdV4hIeW7dB7cECjvtwL8nObBbQAtFO3mgx8HnkFczXe5Mk6Wvn
         XiVdtRtWLhl3ZXRcP+VXIURl5sFX6Kk7Z/kMZ7ibbV+zb7NapAMO4mFERp5Etp2GRzXl
         2nQw==
X-Forwarded-Encrypted: i=1; AJvYcCVMqmFrnmW6LcPlH/C94YUNJdwBsl5uNpucsVgZYl71VaU/Z1cNBaiX1uNP+WkV1CTmfz3KxXJEsEeCAaY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzQw6tH7erRRzAPa8oTZekTHA3AdaZ+j65VJaa/us3ZmxAUl970
	8Dd1iTkvcRmuY9hIG5rsbNlEKdIn2R1y7ZNw82DxBuSEKK33FdcMOXUI5fSa9Ag=
X-Gm-Gg: ASbGnct5bzbdJT9XDU6ApGWF5wD+r8wdg/99sb2dLRdhx/qoWN0hrfqJBctACnc65/z
	Fb5fSocZe8HztpAU/h5YszvKZNVMfosSUs82NAb4P7HAjh1dnQD2HyQOKc/zrJxy5Phh43f7bnz
	4iqG9nvmHLQ9GhYsqPjY7aNoTqFBNrLsH2f4egAzdUHEZuK0bnikYtHYMCM6erwKWbIo1elt0Cm
	FjvCumdVVtMk/+2fKTOseliqgDznR+8b7KD6tkJi+dPLj+8QueDqJngzXpS2bNbn5kmR/3zNkCm
	mjwo0PUSnEp/22yqXoqORDO/6MS6QzH6ykgQn2AlKgNIR9cObGN6fUoCvZzKgZgZVQ60IsK6a+6
	PehwEVghm2A==
X-Google-Smtp-Source: AGHT+IEht0ibCOVwapLKQorYkWh1tvEc+BCDGhekq3S+vwpg3hG7nDeUzCkmGMWNB+hguSfQi069kg==
X-Received: by 2002:a05:600c:314b:b0:43c:ea1a:720c with SMTP id 5b1f17b1804b1-43db624b452mr113357845e9.18.1743457546422;
        Mon, 31 Mar 2025 14:45:46 -0700 (PDT)
Received: from [192.168.1.183] (host-92-26-98-202.as13285.net. [92.26.98.202])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43d82efeacasm177430295e9.23.2025.03.31.14.45.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 31 Mar 2025 14:45:45 -0700 (PDT)
Message-ID: <0da43a86-81b0-4388-b47b-3a76b15f2a4c@citrix.com>
Date: Mon, 31 Mar 2025 22:45:43 +0100
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v1 01/15] x86/msr: Replace __wrmsr() with
 native_wrmsrl()
To: "Xin Li (Intel)" <xin@zytor.com>, linux-kernel@vger.kernel.org,
 linux-perf-users@vger.kernel.org, linux-hyperv@vger.kernel.org,
 virtualization@lists.linux.dev, linux-edac@vger.kernel.org,
 kvm@vger.kernel.org, xen-devel@lists.xenproject.org,
 linux-ide@vger.kernel.org, linux-pm@vger.kernel.org, bpf@vger.kernel.org,
 llvm@lists.linux.dev
Cc: tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
 dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com, jgross@suse.com,
 peterz@infradead.org, acme@kernel.org, namhyung@kernel.org,
 mark.rutland@arm.com, alexander.shishkin@linux.intel.com, jolsa@kernel.org,
 irogers@google.com, adrian.hunter@intel.com, kan.liang@linux.intel.com,
 wei.liu@kernel.org, ajay.kaher@broadcom.com, alexey.amakhalov@broadcom.com,
 bcm-kernel-feedback-list@broadcom.com, tony.luck@intel.com,
 pbonzini@redhat.com, vkuznets@redhat.com, seanjc@google.com,
 luto@kernel.org, boris.ostrovsky@oracle.com, kys@microsoft.com,
 haiyangz@microsoft.com, decui@microsoft.com
References: <20250331082251.3171276-1-xin@zytor.com>
 <20250331082251.3171276-2-xin@zytor.com>
Content-Language: en-GB
From: Andrew Cooper <andrew.cooper3@citrix.com>
Autocrypt: addr=andrew.cooper3@citrix.com; keydata=
 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
 6+ahAA==
In-Reply-To: <20250331082251.3171276-2-xin@zytor.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 31/03/2025 9:22 am, Xin Li (Intel) wrote:
> __wrmsr() is the lowest level primitive MSR write API, and its direct
> use is NOT preferred.  Use its wrapper function native_wrmsrl() instead.
>
> No functional change intended.
>
> Signed-off-by: Xin Li (Intel) <xin@zytor.com>

The critical piece of information you're missing from the commit message
is that the MSR_IMM instructions take a single u64.

Therefore to use them, you've got to arrange for all callers to provide
a single u64, rather than a split u32 pair.

~Andrew

