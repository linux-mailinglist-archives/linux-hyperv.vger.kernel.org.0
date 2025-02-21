Return-Path: <linux-hyperv+bounces-4006-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B3248A3F4E8
	for <lists+linux-hyperv@lfdr.de>; Fri, 21 Feb 2025 14:06:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 02BA24223D3
	for <lists+linux-hyperv@lfdr.de>; Fri, 21 Feb 2025 13:05:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8CD920B7E2;
	Fri, 21 Feb 2025 13:04:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AYW1r8SY"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEB38150980;
	Fri, 21 Feb 2025 13:04:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740143068; cv=none; b=FagXoRFVeLHQwu0bq6l1vi/NJojiqpoHXL0nkgona1H2PFig9LBx5YFV4XsTclvUz33yWTri1KZSM7YyB4AsRtmDhSWJgIrb/uMigZ+TXwnKkteQXtj4/3haTQYn/ANHZJGitMfnJCqfuhbeKJuhX3E8BsmLIMOZgiYOgf/u5ZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740143068; c=relaxed/simple;
	bh=AOTE9050/nKvb/vdg6pehRkE/nL9KFzfRe14a1GPYpQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hIGQ/8rP3d8lL5nLXFyVaf+XQe8mNqKDk5yz/SkjG8dWrnAaAgLe3CsnI6MEMF/oXZT7NlKnfzAyq/jfLwNXiy4T6vvM1uJ8LnKPN/4n+whN/ozuKx2d0Ap4Hb3ofGFk+30CSW+PEko62Q2DDUeOSFvzdkXbIsGmK6Qb8R6m6Rg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AYW1r8SY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4CB7EC4CED6;
	Fri, 21 Feb 2025 13:04:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740143067;
	bh=AOTE9050/nKvb/vdg6pehRkE/nL9KFzfRe14a1GPYpQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=AYW1r8SYP9IftcppJpxAHbSNcURHNdJ8cSErM5QmWT1BpkbZvcRticV4vorDPwkL5
	 m1TsEUbhCFXQVW0F/HTDSfH0YAwE51n4uu+dWA1x+pZZPsi9ykl32wFX5Vdsx3W+u2
	 iO3f6bdG8EI7UPOKKnaqHLMMrmzMmdtuIdoZwJxhHyNtV0QOarCKaAM9gRQLqlqQrW
	 NdlhPlT+Guy7PVGqLk/iwbxQjq2y/wcnaSuJCddWYI8L2bwFE2rxw8ZkOGKwsafUqT
	 fI3FkSD9TsdpmkctCuT5cLtnO0GOoZ8L288Evd4k9rEQwPGmXSd7O4z+EeFT3RUijZ
	 PpJWhcSnVWOmw==
Date: Fri, 21 Feb 2025 14:04:16 +0100
From: Ingo Molnar <mingo@kernel.org>
To: Roman Kisel <romank@linux.microsoft.com>
Cc: bp@alien8.de, dave.hansen@linux.intel.com, decui@microsoft.com,
	haiyangz@microsoft.com, hpa@zytor.com, kys@microsoft.com,
	mingo@redhat.com, tglx@linutronix.de, wei.liu@kernel.org,
	ssengar@linux.microsoft.com, linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org, x86@kernel.org, apais@microsoft.com,
	benhill@microsoft.com, sunilmut@microsoft.com
Subject: Re: [PATCH hyperv-next v2 0/2] x86/hyperv: VTL mode reboot fixes
Message-ID: <Z7h50PqiXxdfMegl@gmail.com>
References: <20250220202302.2819863-1-romank@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250220202302.2819863-1-romank@linux.microsoft.com>


* Roman Kisel <romank@linux.microsoft.com> wrote:

> Roman Kisel (2):
>   x86/hyperv: VTL mode emergency restart callback
>   x86/hyperv: VTL mode callback for restarting the system

A: These two patch titles verbs.
...
...
B: These two patch titles are missing verbs.

Like me you prefer B too, right? If so, please add back the missing 
verbs to the titles. I suggest "Add"/"Introduce", and "Call". Thank you!

	Ingo

