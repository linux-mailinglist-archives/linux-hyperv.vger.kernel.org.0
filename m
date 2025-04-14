Return-Path: <linux-hyperv+bounces-4897-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 57B78A88F2D
	for <lists+linux-hyperv@lfdr.de>; Tue, 15 Apr 2025 00:37:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0B1A53B2C72
	for <lists+linux-hyperv@lfdr.de>; Mon, 14 Apr 2025 22:36:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25AE81F09B4;
	Mon, 14 Apr 2025 22:36:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o9RjfTUT"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4821191493;
	Mon, 14 Apr 2025 22:36:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744670214; cv=none; b=IkdL1eOJ9XP7n/kTmmQyt0WpIx5amg9QXgMoUjcEq+ILzYmf61HqUUBt+TXkGqHjOvAZw4lniPdUSecnLe+1FpIEZ+zlM0YM2hA3rs0ss78TllVUe+0IX6STdM1IWQ0+JTsJVcBMUf+zWyqVBsVReIL2cbzoquIxo3veLhDg964=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744670214; c=relaxed/simple;
	bh=YI4gqpOXRht4Cg1ORHRbMQLHyWPe/MRi++SWYuhqzck=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TDT7AKvDq9FHvOp3YbUL8Ym+mSSuTrNSOgf67sDl39wk+tHCNjSVFM4fENOmzyWI4kSdUgHPJHBqo/1MLArUqaxnqMZZIvluVZ06g6EsiZ1u22V3fe1eT6S8wKL4QfkATyVggAG9rTIywsWTut24Srn8UVDJ/bjTuSMw4KwDkMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o9RjfTUT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D486DC4CEE2;
	Mon, 14 Apr 2025 22:36:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744670213;
	bh=YI4gqpOXRht4Cg1ORHRbMQLHyWPe/MRi++SWYuhqzck=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=o9RjfTUTiXXVjS0IFU+Gy0LB3y3jx89MLqcVzHsGaPowMUNRzdm3s6lCTlAVucOfj
	 W4h3flf9nLrRDm5nFoCiA2yQPDS+HhscUpKKiiP6BPPf4nkcCvpLf6yp1OjEIvUF0e
	 lJWJ8VQ+eIs/8tSsBNJ1UTLBxfmMbiJZz9hAYVn0BaLUnZno34xUOBnwJ5yfhjJ3OO
	 0k5gX5ZjBCpYowOkoqhYJ+UaI6cDUlvzqvsqj7EiEn1xbN7YIF4zFPFu6tdYUvXHya
	 uNxMK3jYD2aPwh6vtEzt0EIt9/LtpUVNSwJSFGt5r/qLjAbaFYwYReT4eBzUE+rtpZ
	 fasOEhkz7IGyw==
Date: Mon, 14 Apr 2025 15:36:50 -0700
From: Josh Poimboeuf <jpoimboe@kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: x86@kernel.org, kys@microsoft.com, haiyangz@microsoft.com, 
	wei.liu@kernel.org, decui@microsoft.com, tglx@linutronix.de, mingo@redhat.com, 
	bp@alien8.de, dave.hansen@linux.intel.com, hpa@zytor.com, 
	pawan.kumar.gupta@linux.intel.com, seanjc@google.com, pbonzini@redhat.com, ardb@kernel.org, 
	kees@kernel.org, Arnd Bergmann <arnd@arndb.de>, gregkh@linuxfoundation.org, 
	linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
	linux-efi@vger.kernel.org, samitolvanen@google.com, ojeda@kernel.org
Subject: Re: [PATCH 3/6] x86/kvm/emulate: Avoid RET for fastops
Message-ID: <7vfbchsyhlsvdl4hszdtmapdghw32nrj2qd652f3pjzg3yb6vn@po3bsa54b6ta>
References: <20250414111140.586315004@infradead.org>
 <20250414113754.172767741@infradead.org>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250414113754.172767741@infradead.org>

On Mon, Apr 14, 2025 at 01:11:43PM +0200, Peter Zijlstra wrote:
> Since there is only a single fastop() function, convert the FASTOP
> stuff from CALL_NOSPEC+RET to JMP_NOSPEC+JMP, avoiding the return
> thunks and all that jazz.
> 
> Specifically FASTOPs rely on the return thunk to preserve EFLAGS,
> which not all of them can trivially do (call depth tracing suffers
> here).
> 
> Objtool strenuously complains about things, therefore fix up the
> various problems:
> 
>  - indirect call without a .rodata, fails to determine JUMP_TABLE,
>    add an annotation for this.
>  - fastop functions fall through, create an exception for this case
>  - unreachable instruction after fastop_return, save/restore

I think this breaks unwinding.  Each of the individual fastops inherits
fastop()'s stack but the ORC doesn't reflect that.

Should they just be moved to a proper .S file?

-- 
Josh

