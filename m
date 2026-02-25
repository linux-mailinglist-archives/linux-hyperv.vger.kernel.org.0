Return-Path: <linux-hyperv+bounces-8992-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SGlaDQ1yn2llcAQAu9opvQ
	(envelope-from <linux-hyperv+bounces-8992-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Wed, 25 Feb 2026 23:05:01 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E05D19E21E
	for <lists+linux-hyperv@lfdr.de>; Wed, 25 Feb 2026 23:05:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id A34A7301C5AF
	for <lists+linux-hyperv@lfdr.de>; Wed, 25 Feb 2026 22:04:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CBC330F53C;
	Wed, 25 Feb 2026 22:04:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="QnMhc20k"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 795AB19E97B;
	Wed, 25 Feb 2026 22:04:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772057095; cv=none; b=hK1JWPqMvIUY5Di48n/32rtFnP7MWE6I2jDXIaao71yX/SKwKwLQiJvbSTl7ZJDoP2ayRvD0TkFFQOVv6+HKfFfrHeqCpzxoQqsGC2qfNGojgnQFYXd1MPVXYEtgJEa8aTB7ezx4y4zIt8Ef1sIaVBkOhGlqNQdJ/KNuUUatl3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772057095; c=relaxed/simple;
	bh=7VmOFNnhsrqi/GUBwUQHVsPUMsSjdfPWvEvPxrrj8Mc=;
	h=Message-ID:Date:MIME-Version:To:From:Cc:Subject:Content-Type; b=uVbMokQH0dz4lLxoUdtqciPf54RvmGnYXKiuFjWsRUMmHKpKA6apGqcQLlrmbUI9D7CdlMeldHskWg36A/45CXkKtXGGcyHVwWdDslHZhlJS9FG9Hl2Oskn2XfPlKTUurJsQklapdQcdjRWTukzImU723qCTmNXvBq6gvUXxXQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=QnMhc20k; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [192.168.0.88] (192-184-212-33.fiber.dynamic.sonic.net [192.184.212.33])
	by linux.microsoft.com (Postfix) with ESMTPSA id DAC6B20B6F02;
	Wed, 25 Feb 2026 14:04:49 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com DAC6B20B6F02
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1772057090;
	bh=7VmOFNnhsrqi/GUBwUQHVsPUMsSjdfPWvEvPxrrj8Mc=;
	h=Date:To:From:Cc:Subject:From;
	b=QnMhc20kOq+nezuINr3Zhkbu5oELv2qVQeLz5d6elQyJM47y7GzGuzvyVM9h9MsXX
	 FLUb4+zlMLWdWY0mJS7Lbs8BiDDpHrwxbcyNc45o9xX6J/UwQakPAIwq4sciZyiYNk
	 J3HuQPXltUeoOgtROXdKy0HVOfVLk8cAoTopS/+w=
Message-ID: <1f50dae2-ec4a-7914-a14f-2ada803eb0e3@linux.microsoft.com>
Date: Wed, 25 Feb 2026 14:04:49 -0800
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Content-Language: en-US
To: alex@shazbot.org
From: Mukesh R <mrathor@linux.microsoft.com>
Cc: kvm@vger.kernel.org, "wei.liu@kernel.org" <wei.liu@kernel.org>,
 "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>
Subject: VFIO support on hyperv (vfio_pci_core_ioctl())
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.microsoft.com,none];
	R_DKIM_ALLOW(-0.20)[linux.microsoft.com:s=default];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-8992-lists,linux-hyperv=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[linux.microsoft.com:+];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FORGED_SENDER_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mrathor@linux.microsoft.com,linux-hyperv@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-hyperv];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 3E05D19E21E
X-Rspamd-Action: no action

Hi Alex et al:

I've been looking at making pci passthru irq setup/remap work on hyperv
for the latest (6.19) version using vfio core. Unfortunately, it's just
not fitting well because in case of hyperv the irq remap is done by
the hypervisor. Specifically, for a robust and proper solution, we need
to override vfio_pci_set_msi_trigger(). As such, for the best way forward
I am trying to figure how much flexibility there is to modify
vfio_pci_intrs.c with "if (running_on_hyperv())" branches (putting hyperv
code in separate file).

If none, then the alternative would be to create vfio-hyperv.c with
vfio_device_ops.ioctl = hyperv_vfio_pci_core_ioctl(). But, then I'd
be replicating code for other sub ioctls like vfio_pci_ioctl_get_info(),
vfio_pci_ioctl_get_irq_info(), etc. Would it be acceptable to make them
non static in this case?

Please let me know your thoughts or if you have other suggestions.

Thanks,
-Mukesh

