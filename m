Return-Path: <linux-hyperv+bounces-8351-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CC374D38915
	for <lists+linux-hyperv@lfdr.de>; Fri, 16 Jan 2026 23:06:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 75034302D2FC
	for <lists+linux-hyperv@lfdr.de>; Fri, 16 Jan 2026 22:06:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5BBC2F8BD3;
	Fri, 16 Jan 2026 22:06:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ki7+D5zM"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FFBA2F49F8;
	Fri, 16 Jan 2026 22:06:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768601183; cv=none; b=URGiwwEF7G6MprgHF2SXcC56RMx5gUGR+D4FLeslBJu1xAlVkUYCx9zFNF+HjPUyn77qYtTtdD4C12tauawtjqRDpyzbwlBzGW7jpEQgSXySfWMYjBraBh+uhmBbn+Tf4Lm8I5BiGy17fFV2Bk21D2/dzppWCcYMrz5CnXX0wBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768601183; c=relaxed/simple;
	bh=EzzsnpJqQeFX65vdO2xqUr8mbhB6kqT5NEAk1PFa+Bo=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=g6CH17NLbkVXUM26F1B9znrfrsZQiTuhto5SjYs5y3a0HjSus0oCOeoj2ssp70t3BtfdkBYQ5YVhc5s1g+kFR1QgP1oVEmp4xCq+M4GPfe6i+MdTDiuEdMTXIY6BMTgW8tlqeY1GxWyeJkVG9Iu5aovgrrQhDo7Wku+JlplOPY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ki7+D5zM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31BF3C116C6;
	Fri, 16 Jan 2026 22:06:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768601183;
	bh=EzzsnpJqQeFX65vdO2xqUr8mbhB6kqT5NEAk1PFa+Bo=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=ki7+D5zMdagPdM1BslM407qhVB0UbFVvlLrCm55ESIxA/+GBlqgePANqrCiw8v0Ye
	 fIoPozH/TPNbLWVTTqAnNuRptROlUrMzU/ng5KOLiyFLWdqcvL1OZlUAfhtMJTE3x/
	 s5fYlggQ2DGNWORsEYTKSAhQ9cc96ANESuXW0PFpKsPU17/RF17xIxJPU78SfPoM3w
	 f3eJ7dZPsakq1VLDcztSfbVHDov21ycDL8TYtHTkduQwuu4DL88vboujReTE7khqzP
	 zXkkzSqj4pooSZX+oRdWPGt+tE5SZyXM4RYRE3onIusjCHHUcb+C6J+TuX05/Yoc8i
	 GzfaplnTEC6CA==
From: Nathan Chancellor <nathan@kernel.org>
To: "K. Y. Srinivasan" <kys@microsoft.com>, 
 Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, 
 Dexuan Cui <decui@microsoft.com>, Long Li <longli@microsoft.com>, 
 Nathan Chancellor <nathan@kernel.org>, 
 Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, 
 Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, 
 Hans de Goede <hansg@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
Cc: linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org, 
 llvm@lists.linux.dev, kernel test robot <lkp@intel.com>
In-Reply-To: <20260115-kbuild-alignment-vbox-v1-0-076aed1623ff@linutronix.de>
References: <20260115-kbuild-alignment-vbox-v1-0-076aed1623ff@linutronix.de>
Subject: Re: [PATCH 0/2] kbuild, uapi: Mark inner unions in packed structs
 as packed
Message-Id: <176860117992.3208640.15511985701328893417.b4-ty@kernel.org>
Date: Fri, 16 Jan 2026 15:06:19 -0700
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.15-dev

On Thu, 15 Jan 2026 08:35:43 +0100, Thomas Weißschuh wrote:
> The unpacked unions within a packed struct generates alignment warnings
> on clang for 32-bit ARM.
> 
> With the recent changes to compile-test the UAPI headers in more cases,
> these warning in combination with CONFIG_WERROR breaks the build.
> 
> Fix the warnings.
> 
> [...]

Applied to

  https://git.kernel.org/pub/scm/linux/kernel/git/kbuild/linux.git kbuild-next

Thanks!

[1/2] hyper-v: Mark inner union in hv_kvp_exchg_msg_value as packed
      https://git.kernel.org/kbuild/c/1e5271393d777
[2/2] virt: vbox: uapi: Mark inner unions in packed structs as packed
      https://git.kernel.org/kbuild/c/c25d01e1c4f2d

Please look out for regression or issue reports or other follow up
comments, as they may result in the patch/series getting dropped or
reverted. Patches applied to an "unstable" branch are accepted pending
wider testing in -next and any post-commit review; they will generally
be moved to the main branch in a week if no issues are found.

Best regards,
-- 
Nathan Chancellor <nathan@kernel.org>


