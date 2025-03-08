Return-Path: <linux-hyperv+bounces-4294-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 90966A57823
	for <lists+linux-hyperv@lfdr.de>; Sat,  8 Mar 2025 04:52:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B13F016F250
	for <lists+linux-hyperv@lfdr.de>; Sat,  8 Mar 2025 03:52:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5A8317A306;
	Sat,  8 Mar 2025 03:50:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T5ucwuau"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DDA7169AE6;
	Sat,  8 Mar 2025 03:50:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741405831; cv=none; b=rstn4bJuPvdN+BfN/9r6FrgiyWWCy/qDyps+BYJAuobBZhANsL9R4sj3pU8p9kNzjNtxnCpm35ooFNTBIBMDm9zChSCK5nFhlSYXpcitHZggv9QcsFULheN18cyG6n1xRXPOyS5gp3/XiMYKhjDHBsfVRBVdlbkpJOiSyca1vxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741405831; c=relaxed/simple;
	bh=thNru/J8O4N9hCvQBln45Ii9nJYq1lZSQziQYfLtouc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=o9bqEsXt+mS6n2jgAay/ZCJHf7pZzHFLPBqBGx7nO7pcdMICFrwVx9GmErz4HqqvPesiz1qDKu16yn9Nz6ebTl7Bk2xw4drQkBRxWwSms2mlrHdSAaVyvBOb5QpbnFA0ia/vi2cI8Z5sEEFSa/zR9ArLjCA8kz8Y7EGPwmgHQeE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T5ucwuau; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 577DEC4CEE0;
	Sat,  8 Mar 2025 03:50:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741405831;
	bh=thNru/J8O4N9hCvQBln45Ii9nJYq1lZSQziQYfLtouc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=T5ucwuauqG1W/nrQFZDbIFfy7Pl86HpD+CcU99Kyipq4gMn1T3pPF+f4zA60B+zL/
	 Qm36MeyVj0Qrr/18aii0vjRP6Jw4wu8Kt87paitKHx7t8Dsr0yUz+67y80AuU7Ejvt
	 zwJxD+2dScZV3H2nnvmzKIYug4Q9fzhGB9mzjwNGV0/8GAJ0kEdAfDlRQxo2s9hg8q
	 up1ppFMrfTP5B4bfyv4U8BoeaY8YuV0ewCHXlJuI5PyYq0i+Gpq36/dssFBifEjylw
	 aTMGo1tkZxpIatqGzPM2uAI9yl4k9LO1oGAO3EJr8TJJ+pjGdbYnEUbGMAZCsJY378
	 hMeLhM/JuF1uw==
Date: Fri, 7 Mar 2025 19:50:29 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Haiyang Zhang <haiyangz@microsoft.com>
Cc: linux-hyperv@vger.kernel.org, netdev@vger.kernel.org,
 decui@microsoft.com, stephen@networkplumber.org, kys@microsoft.com,
 paulros@microsoft.com, olaf@aepfle.de, vkuznets@redhat.com,
 davem@davemloft.net, wei.liu@kernel.org, edumazet@google.com,
 pabeni@redhat.com, leon@kernel.org, longli@microsoft.com,
 ssengar@linux.microsoft.com, linux-rdma@vger.kernel.org,
 daniel@iogearbox.net, john.fastabend@gmail.com, bpf@vger.kernel.org,
 ast@kernel.org, hawk@kernel.org, tglx@linutronix.de,
 shradhagupta@linux.microsoft.com, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Subject: Re: [PATCH net] net: mana: Support holes in device list reply msg
Message-ID: <20250307195029.1dc74f8e@kernel.org>
In-Reply-To: <1741211181-6990-1-git-send-email-haiyangz@microsoft.com>
References: <1741211181-6990-1-git-send-email-haiyangz@microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed,  5 Mar 2025 13:46:21 -0800 Haiyang Zhang wrote:
> -	for (i = 0; i < max_num_devs; i++) {
> +	for (i = 0; i < GDMA_DEV_LIST_SIZE &&
> +		found_dev < resp.num_of_devs; i++) {

unfortunate mis-indent here, it blend with the code.
checkpatch is right that it should be aligned with opening bracket

>  		dev = resp.devs[i];
>  		dev_type = dev.type;
>  
> +		/* Skip empty devices */
> +		if (dev.as_uint32 == 0)
> +			continue;
> +
> +		found_dev++;
> +		dev_info(gc->dev, "Got devidx:%u, type:%u, instance:%u\n", i,
> +			 dev.type, dev.instance);

Are you sure you want to print this info message for each device,
each time it's probed? Seems pretty noisy. We generally recommend
printing about _unusual_ things.

