Return-Path: <linux-hyperv+bounces-6265-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 01A5DB06CBF
	for <lists+linux-hyperv@lfdr.de>; Wed, 16 Jul 2025 06:42:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6D7C71AA306D
	for <lists+linux-hyperv@lfdr.de>; Wed, 16 Jul 2025 04:42:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9C852528F7;
	Wed, 16 Jul 2025 04:42:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="E6KHW3ND"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76BD52E3715;
	Wed, 16 Jul 2025 04:42:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752640933; cv=none; b=VZx8wFS3G3lRdisgrKTp+0mYC87ncOKVK0g1DV3BOYsGJw7RDB0sxarVSQNJW7vV7ubNf60ZEvoSW+C3AIDmACDsp9U6tgrToSWFXcvy3m6FjMsKlOU79k5D6bYHzHA2xdetXDA2+ZmV5qc8x8U0/756Els2ABJLRKQg4aDDTVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752640933; c=relaxed/simple;
	bh=k7xs9Um3WsTVzWrqkDSGhj9tol3AITVQEo38acvwWfU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=mqnFvWm9Sq1GTbZrouWbRs5VfEh0K9JiqoNojtVgx5E6YY8yMKlbyAi593SHpzeKbXE/9ZITgrJBKvPy1s+ZuBEoJKdu+Mns5rFmxcgBRxPr9JBGv0DYhdjXbc40jlZAIaDB3SHdl3s4ILuwo0CR9n6Frxa2oxNHARL1sJHQeTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=E6KHW3ND; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1158)
	id 12003201BA2F; Tue, 15 Jul 2025 21:42:12 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 12003201BA2F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1752640932;
	bh=CJStzbQ9VHhLyMURv3oxT/RMbHXq0YRsR3c4GhGdSyI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=E6KHW3NDiaZlgiigzMwg6PVjsFpZ1ubbZ37Cxj1MuwN15yJF4R20qFUu1RDJoakdc
	 vrbSvo8kMNf8J0fpSWcdsgn9y0Lg3OHluj1Qqt63f86s/uGUfyUEw0ZrVaZZ4WJkob
	 Exf9ZWnsVkzbb7Yp0ch/F1FJomsygfdhFXni9uV8=
From: Hardik Garg <hargar@linux.microsoft.com>
To: krzk@kernel.org
Cc: apais@microsoft.com,
	conor+dt@kernel.org,
	decui@microsoft.com,
	devicetree@vger.kernel.org,
	haiyangz@microsoft.com,
	hargar@linux.microsoft.com,
	hargar@microsoft.com,
	krzk+dt@kernel.org,
	kys@microsoft.com,
	linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	robh@kernel.org,
	ssengar@linux.microsoft.com,
	wei.liu@kernel.org
Subject: Re: [PATCH v4 1/2] dt-bindings: microsoft: Add vmbus message-connection-id property
Date: Tue, 15 Jul 2025 21:42:12 -0700
Message-Id: <1752640932-23038-1-git-send-email-hargar@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <63ca8d08-2fd3-440e-858a-f8d79890016f@kernel.org>
References: <63ca8d08-2fd3-440e-858a-f8d79890016f@kernel.org>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>

>>>> What is a connection ID and why it cannot be inferred from existing
>>>> system API?
 
>> The connection-id determines which hypervisor communication channel the
>> guest should use to talk to the VMBus host. Reading from DeviceTree allows
>> platforms to specify their preferred communication channel, making it more
>> flexible (I will add this detail in the commit message). Presently, this
 
>> We don't add properties to make things flexible.
 
You're right. I should have explained better. The connection ID is a hardware 
configuration detail that defines which specific VMBus channel is used for 
host-guest communication. This value is configured by the host and passed to 
the guest through the host's device tree. Different hypervisor versions and 
configurations may require different channels, and this needs to be specified 
by the platform.
 
>>>> There's a reason why you have here generic property - this is generic
>>>> and/or discoverable and/or whatever software interface. Adding now more
>>>> properties, just because you made it generic, is not the way.
 
>> Presently the value is hardcoded and we want to provide a functionality to
>> the user to specify their prefered communication channel. This is a
>> virtualized hardware property for us.
 
>> That's not really acceptable reason. With such approach I would add 100
>> properties to make various things "flexible".
 
I understand your concern. Let me clarify: this isn't about making things 
flexible for flexibility's sake. The connection ID is a fundamental hardware 
configuration parameter that is set by the host and must be matched in the 
guest. The host configures this value in its device tree and shares it with 
the guest. Without the correct channel ID, the VMBus communication fails. 
Different hypervisor configurations require different channels, and this 
cannot be automatically discovered.
 
Would you prefer if we handled this configuration through a different 
mechanism? I'm open to suggestions.




Thanks,
Hardik

