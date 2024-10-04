Return-Path: <linux-hyperv+bounces-3120-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 375DA990084
	for <lists+linux-hyperv@lfdr.de>; Fri,  4 Oct 2024 12:08:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DD7A11F21CBC
	for <lists+linux-hyperv@lfdr.de>; Fri,  4 Oct 2024 10:08:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2932314A60F;
	Fri,  4 Oct 2024 10:07:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="eeM1whbH"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20FF413A257;
	Fri,  4 Oct 2024 10:07:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728036477; cv=none; b=eJhrVFqjV8+4fuADlAzJ4psercRsp4P47jr7P4RRpKcGWmAcCg3sau75VggzDW09vxX1c2O013sSZtw0cjVrHi3wlS1tp1/cGF7Zu+Vfqw8VYZmhxNh3xEmNpGRG6nt4FLCjgG7fpo3Aq+0d5Nvk+VwbPA6uOdzZ+dUvYysO04I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728036477; c=relaxed/simple;
	bh=0ErE4yIzJ4CNSK9JS5t8RilNBwBBL9q+8Xv9BI3Apzo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FGHyIvZ9evasH16Z2IrnECi8sZPrOy7st318QUJZsklEm8w2l5N9bXBdWuvDiKePLB/VbkhWDdXBhga2xhXvSyQKsiUbNQwsI+2CUNSsV/cjRM5BBBDyPzX35vO/K+5d0Dtj1JHsRXfqnS+oAnw3PgBduukc8oRQin74H34/LTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=eeM1whbH; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=xqlikl0bG4GDsTQjaI8kd8CnGG7Ve6tkOtKZn8x5TY4=; b=eeM1whbHI/rFHiUwezCgI/bZ+R
	HXNswooL56X6/oGJqMRyOAanoRxmGuhhvrmBk7gNA9x+tYx70Z2pE1AW8+etEkfvv5Va5X82eiI1E
	J8nmw/BkWyvoqGaKRu876fSGyOVNtlF49WTx4OsAvYUrJ/Xx84PMUtroGsIQGqC5VTciUQgzpzLIj
	ssVM8ctoBL9geCR4R0Qu8vXFYAJpXFlK9w9FxUrsMNqGgSN04t7npSKv9r8xrMq8x1AKMMo7nFUJz
	uLj5nHU+e38Q2uP1sjYBAWy1V0zcAccfRLmne+Cd41vJlPV2vBkOuKE69+S3l3rLyQKAqGUWq0G3Y
	nAC4B0Rg==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1swfDr-00000003ofA-1fE6;
	Fri, 04 Oct 2024 10:07:43 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 9B45A30083E; Fri,  4 Oct 2024 12:07:42 +0200 (CEST)
Date: Fri, 4 Oct 2024 12:07:42 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: mhklinux@outlook.com
Cc: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
	decui@microsoft.com, tglx@linutronix.de, mingo@redhat.com,
	bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org,
	hpa@zytor.com, joro@8bytes.org, will@kernel.org,
	robin.murphy@arm.com, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com,
	James.Bottomley@hansenpartnership.com, martin.petersen@oracle.com,
	iommu@lists.linux.dev, netdev@vger.kernel.org,
	linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-scsi@vger.kernel.org
Subject: Re: [PATCH 0/5] hyper-v: Don't assume cpu_possible_mask is dense
Message-ID: <20241004100742.GO18071@noisy.programming.kicks-ass.net>
References: <20241003035333.49261-1-mhklinux@outlook.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241003035333.49261-1-mhklinux@outlook.com>

On Wed, Oct 02, 2024 at 08:53:28PM -0700, mhkelley58@gmail.com wrote:
> 
> Michael Kelley (5):
>   x86/hyperv: Don't assume cpu_possible_mask is dense
>   Drivers: hv: Don't assume cpu_possible_mask is dense
>   iommu/hyper-v: Don't assume cpu_possible_mask is dense
>   scsi: storvsc: Don't assume cpu_possible_mask is dense
>   hv_netvsc: Don't assume cpu_possible_mask is dense

Thanks, these look sane.

Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>

