Return-Path: <linux-hyperv+bounces-3648-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 45C14A08146
	for <lists+linux-hyperv@lfdr.de>; Thu,  9 Jan 2025 21:18:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 41FA13A7EF4
	for <lists+linux-hyperv@lfdr.de>; Thu,  9 Jan 2025 20:18:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 028991FA8D9;
	Thu,  9 Jan 2025 20:18:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="roTsdMqz"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8BA11F9ED1;
	Thu,  9 Jan 2025 20:18:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736453883; cv=none; b=MhaNcICkb1olT/JLZpj92ybtbP7opHie9dCTJfCRXt3ScjMUku79p6+RlqHRADJN/2W2wZ2FRye8bYXlWYjPgKu8OumOiy2+aNF7i7qfE0Nyz+IfFgM3ti86RwyOfQ9eindKXiNBLrjNfng6Eo4zacnzR+gonelzlu/RZsA+mM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736453883; c=relaxed/simple;
	bh=fuxxKjqSod6XoGgBtWH7MSjsb0PEYcT+4CZp0A0fWtA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pnDXVu+3P80mxj1wHR2nkj5UPeM//Or4WI3zNTQqzMRFwbemW/hgPyKq8tsCIaQ7QMdTGneKIT5Gu8KAZd5gFPH5ayAY9at2sSPOuUzKADq5Y7hYzyiF2CKdTkdoMcWskejHH95G+egFAwz39lxybU0Cz2qE2Ztd0SK0c9dqkmg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=roTsdMqz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D5EBC4CED2;
	Thu,  9 Jan 2025 20:18:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736453883;
	bh=fuxxKjqSod6XoGgBtWH7MSjsb0PEYcT+4CZp0A0fWtA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=roTsdMqzW4NGQPtyKmh44UxVR4dI+UjrmlQBoaTOq95k4R01zrbJ3+WfTfaD7SsgL
	 0Yv1DMher7ytcoWbtdF1VKR8QiUVSPiu2HKeTrWyxZ/AiUzmdiNjIkINkomhAHJzqy
	 c/C4Ma02elQCop3IRmdC5tGYeuxb2OStR2Qvyr4KyfZJXoapBqbHdkKKoKUxzddcv5
	 Gobp0tzzNkrJaFirl/eCiAyPZfgI+6qOkCJsjEDkdE/tpiWRAfHVpu8zwYYtlJZ6ZY
	 hTJKVWNnUpZtBSAnACOjtUorzeIPdbYWycer+PxaLMdGse8tebondhFrS+ZslV6YNF
	 vE77GgUqTlDiQ==
Date: Thu, 9 Jan 2025 20:18:01 +0000
From: Wei Liu <wei.liu@kernel.org>
To: Roman Kisel <romank@linux.microsoft.com>
Cc: hpa@zytor.com, kys@microsoft.com, bp@alien8.de,
	dave.hansen@linux.intel.com, decui@microsoft.com,
	eahariha@linux.microsoft.com, haiyangz@microsoft.com,
	mingo@redhat.com, mhklinux@outlook.com,
	nunodasneves@linux.microsoft.com, tglx@linutronix.de,
	tiala@microsoft.com, wei.liu@kernel.org,
	linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
	x86@kernel.org, apais@microsoft.com, benhill@microsoft.com,
	ssengar@microsoft.com, sunilmut@microsoft.com, vdso@hexbites.dev
Subject: Re: [PATCH v6 0/5] hyperv: Fixes for get_vtl(),
 hv_vtl_apicid_to_vp_id()
Message-ID: <Z4Au-chfvfXCt-zq@liuwe-devbox-debian-v2>
References: <20250108222138.1623703-1-romank@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250108222138.1623703-1-romank@linux.microsoft.com>

On Wed, Jan 08, 2025 at 02:21:33PM -0800, Roman Kisel wrote:
[...]
> Roman Kisel (5):
>   hyperv: Define struct hv_output_get_vp_registers
>   hyperv: Fix pointer type in get_vtl(void)
>   hyperv: Enable the hypercall output page for the VTL mode
>   hyperv: Do not overlap the hvcall IO areas in get_vtl()
>   hyperv: Do not overlap the hvcall IO areas in hv_vtl_apicid_to_vp_id()

The patches have been pushed to hyperv-next. Roman and Nuno, please
check the tree for correctness.

Thanks,
Wei.

