Return-Path: <linux-hyperv+bounces-5758-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DF71FACD68B
	for <lists+linux-hyperv@lfdr.de>; Wed,  4 Jun 2025 05:27:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 00CE2188FFF4
	for <lists+linux-hyperv@lfdr.de>; Wed,  4 Jun 2025 03:27:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7ECF015665C;
	Wed,  4 Jun 2025 03:27:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="VnEzoKzx"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 021D729A2;
	Wed,  4 Jun 2025 03:27:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749007643; cv=none; b=KLumlIlmWRaIF+J7UJ6/vXzfIcDtHyg9kALcpdFLquWSxFsKX5ZH06tQgEoZIwM8Sp6ZCFXGPFPk9aXM2XVj3X+rcnRjnbSXOu18aBFcbq70yWZ1zfPMGbEBT7KdR8uvrZU2pMlMedBynrjSXabuMyDcQiLMy2EWqLOqfyxAgWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749007643; c=relaxed/simple;
	bh=L739ankpOODrb0fgXoxcqqKEaECRiZEI57Fnw+a3DXU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l55AnTluGMP+8K7U7HvV5Xa0NjkjBo6n8pYho5CpBnRjphcKAn0yCvH/UGQPcVKAVprdgZEdzYF2TTa/Xpe4I8PPb2VCkmzx3/PajtuxYevm3stintVnKshq/Zvx/OWH58ekGQME2RNxAH1tbsjrgRmXBrZOxEzAyIyVB0/S6gM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=VnEzoKzx; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1127)
	id 69CAF211658D; Tue,  3 Jun 2025 20:27:21 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 69CAF211658D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1749007641;
	bh=IGK1+y6vAvC4yF9XTkE5Ky7qInkd4kQfnxz5ym+8224=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VnEzoKzxf/uapaR09G3w1stJu4kQl6PRmk6zbdcmNuLeyuNWcYWvStveQNSw68NLh
	 klECQPpyE+OWDb2n4Zx9rE055pHuE5mAPf8pSO1ZoUMUWwjdyrFHFXqlCl82Vd8Hel
	 wHG4GBak0vcnkcwK4Q4NRXqpCn8rsWSm+uh9PuEU=
Date: Tue, 3 Jun 2025 20:27:21 -0700
From: Saurabh Singh Sengar <ssengar@linux.microsoft.com>
To: Hardik Garg <hargar@linux.microsoft.com>
Cc: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
	decui@microsoft.com, ssengar@microsoft.com,
	romank@linux.microsoft.com, linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@kernel.org,
	apais@microsoft.com
Subject: Re: Subject: [PATCH v2] vmbus: retrieve connection-id from DeviceTree
Message-ID: <20250604032721.GA31886@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <096edaf7-cc90-42b6-aff4-c5f088574e1e@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <096edaf7-cc90-42b6-aff4-c5f088574e1e@linux.microsoft.com>
User-Agent: Mutt/1.5.21 (2010-09-15)

On Tue, Jun 03, 2025 at 02:01:00PM -0700, Hardik Garg wrote:
> The connection-id determines which hypervisor communication channel the
> guest should use to talk to the VMBus host. This patch adds support to
> read this value from the DeviceTree where it exists as a property under
> the vmbus node with the compatible ID "microsoft,message-connection-id".
> The property name follows the format <vendor>,<field> where
> "vendor": "microsoft" and "field": "message-connection-id"
> 
> Reading from DeviceTree allows platforms to specify their preferred
> communication channel, making it more flexible. If the property is
> not found in the DeviceTree, use the default connection ID
> (VMBUS_MESSAGE_CONNECTION_ID or VMBUS_MESSAGE_CONNECTION_ID_4
> based on protocol version).
> 
> Signed-off-by: Hardik Garg <hargar@linux.microsoft.com>
> ---
> v2:
> - Rebased on hyperv-next branch as requested by maintainers
> - Added details about the property name format in the commit message

Property need to be documented in Documentation/devicetree/bindings/bus/microsoft,vmbus.yaml

- Saurabh

> 

