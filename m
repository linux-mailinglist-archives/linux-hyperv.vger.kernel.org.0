Return-Path: <linux-hyperv+bounces-5979-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 37F65AE14CA
	for <lists+linux-hyperv@lfdr.de>; Fri, 20 Jun 2025 09:22:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C30013AF9A8
	for <lists+linux-hyperv@lfdr.de>; Fri, 20 Jun 2025 07:21:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF13C22759C;
	Fri, 20 Jun 2025 07:22:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GJ64G+TC"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8311E30E85C;
	Fri, 20 Jun 2025 07:22:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750404127; cv=none; b=F4YYVLMg63UK3FUQ+oWAtYHzI5VFZ8cdgwQD4xiRNbF0XDiZJ6LAvscDrtjLG2enp1UPlrmgeWzh9GWPxunNzy0OwwAfiT3wYbVfMYDX6ss0vPGM4X9Gqhr1e3o1wD1OCjIbCAgNKSdwrmpa2UA47qImeiPBujvcMM2L7Q6zyR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750404127; c=relaxed/simple;
	bh=5RPAq0Ia69osMsa70Jk9HSRpAEfxlhKNmA/7/I1S0Pg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WWKINuZsAQSQIsork/H9m6ccqM4a0xm9GEQJckl2XhZF4hIwXUT1iy9NB8cylgOFGx9YYs0SBI+W4Rfv7x/kDZxdRA6lhghrZr2huLoMLyXhWboQ4piTFApOnBaVTG3XsCmQjWpGN6jon5GqgIlvkfrPQHrwhSYFWQx4r1TQe34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GJ64G+TC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB2B8C4CEE3;
	Fri, 20 Jun 2025 07:22:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750404127;
	bh=5RPAq0Ia69osMsa70Jk9HSRpAEfxlhKNmA/7/I1S0Pg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GJ64G+TCI+QHThsiEaKisdrrzaIC8mNN1kXyFDKDkncbuhxRq5Jm1pqRsZQ+gesuD
	 9rqDmkugl+vIlP9OHgU5OX1HJ3ChyVcFItvHK0oxzmExEPoantG6iLimuoFzU/JxjW
	 EaztZ0R2uER86C2sg8/0S8nJofVYVCqafVXfs2ICIoJx97J6dlV2Z/2cbyMBTn/hq6
	 FqsYjieUkBLpW+OvINs2MEujQoiVo+ZMvwVQjLyC1W/1jdu+Y/DfcWS+gC/bywAmWY
	 s9/gMB+LFpa1x/A8APjO/JQFjZIzlb3KYiQJoK0ns5mudxJ2bZZTwMU8D1LJ9Z/oBK
	 aNIwO2rJkH2xA==
Date: Fri, 20 Jun 2025 09:22:04 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Hardik Garg <hargar@linux.microsoft.com>
Cc: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org, 
	decui@microsoft.com, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	devicetree@vger.kernel.org, linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org, 
	ssengar@linux.microsoft.com, hargar@microsoft.com, apais@microsoft.com
Subject: Re: [PATCH v4 2/2] vmbus: retrieve connection-id from DeviceTree
Message-ID: <20250620-miniature-wisteria-moose-8d8cf8@kuoka>
References: <1750374395-14615-1-git-send-email-hargar@linux.microsoft.com>
 <1750374395-14615-3-git-send-email-hargar@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1750374395-14615-3-git-send-email-hargar@linux.microsoft.com>

On Thu, Jun 19, 2025 at 04:06:35PM GMT, Hardik Garg wrote:
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
> v3: https://lore.kernel.org/all/6a92ca86-ad6b-4d49-af6e-1ed7651b8ab8@linux.microsoft.com
> v2: https://lore.kernel.org/all/096edaf7-cc90-42b6-aff4-c5f088574e1e@linux.microsoft.com
> v1: https://lore.kernel.org/all/6acee4bf-cb04-43b9-9476-e8d811d26dfd@linux.microsoft.com
> ---
>  drivers/hv/connection.c |  6 ++++--
>  drivers/hv/vmbus_drv.c  | 13 +++++++++++++
>  2 files changed, 17 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/hv/connection.c b/drivers/hv/connection.c
> index be490c598785..15d2b652783d 100644
> --- a/drivers/hv/connection.c
> +++ b/drivers/hv/connection.c
> @@ -99,11 +99,13 @@ int vmbus_negotiate_version(struct vmbus_channel_msginfo *msginfo, u32 version)
>  	if (version >= VERSION_WIN10_V5) {
>  		msg->msg_sint = VMBUS_MESSAGE_SINT;
>  		msg->msg_vtl = ms_hyperv.vtl;
> -		vmbus_connection.msg_conn_id = VMBUS_MESSAGE_CONNECTION_ID_4;
>  	} else {
>  		msg->interrupt_page = virt_to_phys(vmbus_connection.int_page);
> -		vmbus_connection.msg_conn_id = VMBUS_MESSAGE_CONNECTION_ID;
>  	}
> +	/* Set default connection ID if not provided via DeviceTree */
> +	if (!vmbus_connection.msg_conn_id)

Your binding said connection ID 0 is a valid one, so this is wrong. Or
binding is wrong.

Best regards,
Krzysztof


