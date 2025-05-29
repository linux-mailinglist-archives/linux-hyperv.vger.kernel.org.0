Return-Path: <linux-hyperv+bounces-5690-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 369DEAC7844
	for <lists+linux-hyperv@lfdr.de>; Thu, 29 May 2025 07:50:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9390B9E139B
	for <lists+linux-hyperv@lfdr.de>; Thu, 29 May 2025 05:50:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4C8825B1D2;
	Thu, 29 May 2025 05:43:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="TZkt8Kj4"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44C4F25A648;
	Thu, 29 May 2025 05:43:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748497434; cv=none; b=HpNBS3lsMqP2dMr68z4MGyXKWVEInsJP6OeWpJv6Y4hZH2ZmFZ/sofB0uBVO+7xG6jvI4gtH990r8PTvRWnCeaDyMCWTKd51wPWBVxv49Am2QYgLCTFqrmIN5Jmc3nYaB3iacntkwRO/IPp8Cww+ACNsnmnhu4LJY2mOFf0UOjE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748497434; c=relaxed/simple;
	bh=Hf/9FWJoGCnVz+n/KZJ+U0j43CoQU/bpcDA8QcEuAAU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=euH0p0xiWljfz71nsJy7jDvWGNBySzOOPoHpGgrD1ASv5vIlcKJm00ccAj99RKv0lY4luOy6bNwV8RVFrAPP6RnZWu0AtVIj9fDB/Rwt5JY97yHsAIYgji6qAn0WSCUKxFTtbNcN9YVvS4Gsy6xzI8/prcwKgLktvrHLBTY3pqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=TZkt8Kj4; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1127)
	id B3406203EE1B; Wed, 28 May 2025 22:43:52 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com B3406203EE1B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1748497432;
	bh=cBY/3tzV7eYWwlwoKVvpDZ7aI+M46lAum5z741O0Bls=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TZkt8Kj4tSj0D8BKj2tV5hLpdjxF3oD1oMu6T9rO6sNYnT7tYTTBYWx2cLMoEHNPF
	 4QqqM5JdvJIwh6sMnvJ9+ZBC57wXKx5mz49l1Xiji/o8KR19wZhqAWn34qDdSpEo9f
	 RCwb3q/BYV+Qqj8nyw0zpJzxyt2N15L10tP7UcFU=
Date: Wed, 28 May 2025 22:43:52 -0700
From: Saurabh Singh Sengar <ssengar@linux.microsoft.com>
To: Hardik Garg <hargar@linux.microsoft.com>
Cc: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
	decui@microsoft.com, romank@linux.microsoft.com,
	linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@kernel.org, ssengar@microsoft.com, apais@microsoft.com
Subject: Re: [PATCH] vmbus: retrieve connection-id from device tree
Message-ID: <20250529054352.GA29740@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <6acee4bf-cb04-43b9-9476-e8d811d26dfd@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6acee4bf-cb04-43b9-9476-e8d811d26dfd@linux.microsoft.com>
User-Agent: Mutt/1.5.21 (2010-09-15)

On Wed, May 28, 2025 at 02:33:25PM -0700, Hardik Garg wrote:
> The connection-id determines which hypervisor communication channel the
> guest should use to talk to the VMBus host. This patch adds support to
> read this value from the device tree where it exists as a property under
> the vmbus node with the compatible ID "microsoft,message-connection-id".

Add Documentation for "microsoft,message-connection-id"

> 
> Reading from device tree allows platforms to specify their preferred
> communication channel, making it more flexible. If the property is
> not found in the device tree, use the default connection ID
> (VMBUS_MESSAGE_CONNECTION_ID or VMBUS_MESSAGE_CONNECTION_ID_4
> based on protocol version).
> 
> Cc: <stable@kernel.org> # 6.14, 6.12

I don't see it as as bug which needs to be backported on certain branches only.
You can rebase your changes on linux-next or hyperv-next and resend.

Also,

s/device tree/DeviceTree/g


- Saurabh

