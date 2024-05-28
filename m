Return-Path: <linux-hyperv+bounces-2221-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A71218D13F0
	for <lists+linux-hyperv@lfdr.de>; Tue, 28 May 2024 07:33:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 43056B21161
	for <lists+linux-hyperv@lfdr.de>; Tue, 28 May 2024 05:33:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DEA01C68D;
	Tue, 28 May 2024 05:33:50 +0000 (UTC)
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3EBF4CB2B;
	Tue, 28 May 2024 05:33:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716874429; cv=none; b=FB5GcojGsuhh2ZeXV5QquGB9L2hgp3+ov6wj3Q0sohE3/TmP7BU7ew42qmEjXYX3esD1kRiFKh2Ji4zjIENrUSdVO+9tLpqgKSJMr/RU3QUnYZJNzt9rdjYb/CVQD8nRdSP1fIqHcI1K4DMHud1IpinUpOL0XdAs0LI+NtKpvEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716874429; c=relaxed/simple;
	bh=s05Frly+jsi9ApRgAMiozaXpR67rihNmFY6csDtyDUg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HZMRcgMkgBFywdusNm6XuXphOdV8MChpObr5DojqWCwk3N8y1lYfEZxzyMdr1+kPO8y3e3r6twJKwRZZokG3XbHJg8gNopuckEYs+Y7o2G9TJ/osmDUEz1nO/IzT1Ch+izV1jiqfQrRod0m00nv01C8IGfyJmvpycUctOcgapj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-2bdf446f3d1so310283a91.3;
        Mon, 27 May 2024 22:33:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716874428; x=1717479228;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fN6LRL+FsIHhjPUj0yA5DeMxhwLzqKe44DGJ+zjen+s=;
        b=FuKzAXX8Vb05v+iLQYGXBfVDgT4/3h2s/pUrtLJrg5e5HRpl54dFk84G3wPL56YQch
         G7K6Ib2aAbpD/BEQ5apV/LDStqT1nEds2FRcLFBTDuKy1gkJV/JFD05HdoxmoxkfVNH9
         SmZ4ukMvv1XqJDbR0J/thrldqufjq2QV4cmY23R7sqHx4m5Vlz9Ip7ev5/CJA8Yn0a2u
         lWq1vy+RCUixcIALrqaMj+SjfHenc6BvbXnz5T477jEJHjkARIrMogP32bb6M2Dtl5s6
         u18Um7HsnyFOQPfCKoiLrbk64TLx+KLTc4imjgmlEZ/DCZhTFfsx0PgOB16O00grchXQ
         BFBw==
X-Forwarded-Encrypted: i=1; AJvYcCVRHfKn7JqD7LhQNPAiiJ3XlPMc1xRBPmTMm9O71SMYiOkoNWuQgE5WQTmZLkZHN6/vsU7GOOYzMaVxj7dMqcVmByUn75fO1NKr1ZpHo7LAnLtqmAvlfjauHGyohZUPZ34zSSeRR0eiOG7Y
X-Gm-Message-State: AOJu0YyqC7SgP0vOQJ3Knregzc7N8l7+6Rjep0UkW8SvgVYXCklOAQEs
	oDb+46Vi4ju/iX0wwFkAVJPvT+UD6Jk/wxT/KEmc4DtMbb7pVa//
X-Google-Smtp-Source: AGHT+IHse1I9e6UDY482/9q4rxCeoBsLH1h8sqxmlnuIt2y7ohHDp0RwxMIzcOm0aIibGNazirrQgg==
X-Received: by 2002:a17:90a:d143:b0:2c0:11d4:b2e0 with SMTP id 98e67ed59e1d1-2c011d4b31bmr354237a91.34.1716874428096;
        Mon, 27 May 2024 22:33:48 -0700 (PDT)
Received: from liuwe-devbox-debian-v2 ([20.69.120.36])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2bdd9ed2cc7sm8835972a91.3.2024.05.27.22.33.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 May 2024 22:33:47 -0700 (PDT)
Date: Tue, 28 May 2024 05:33:46 +0000
From: Wei Liu <wei.liu@kernel.org>
To: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc: Sean Christopherson <seanjc@google.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
	"K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>, linux-coco@lists.linux.dev,
	linux-kernel@vger.kernel.org, linux-hyperv@vger.kernel.org
Subject: Re: [PATCH 06/20] x86/tdx: Convert MSR write handling to use new
 TDVMCALL_0()
Message-ID: <ZlVsurj64QycDQRr@liuwe-devbox-debian-v2>
References: <20240517141938.4177174-1-kirill.shutemov@linux.intel.com>
 <20240517141938.4177174-7-kirill.shutemov@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240517141938.4177174-7-kirill.shutemov@linux.intel.com>

On Fri, May 17, 2024 at 05:19:24PM +0300, Kirill A. Shutemov wrote:
> Use newly introduced TDVMCALL_0() instead of __tdx_hypercall() to handle
> MSR write emulation.
> 
> It cuts code bloat substantially:
> 
> Function                                     old     new   delta
> tdx_handle_virt_exception                   1947    1819    -128
> 
> Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> ---
>  arch/x86/coco/tdx/tdx.c | 9 ++-------
>  arch/x86/hyperv/ivm.c   | 9 ++-------

Acked-by: Wei Liu <wei.liu@kernel.org>

