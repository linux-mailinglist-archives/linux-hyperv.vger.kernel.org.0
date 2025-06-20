Return-Path: <linux-hyperv+bounces-5978-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CF8EAE14C0
	for <lists+linux-hyperv@lfdr.de>; Fri, 20 Jun 2025 09:21:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AF3811707A9
	for <lists+linux-hyperv@lfdr.de>; Fri, 20 Jun 2025 07:21:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DF1822759C;
	Fri, 20 Jun 2025 07:21:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TuHKoPlV"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22F8830E85C;
	Fri, 20 Jun 2025 07:21:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750404063; cv=none; b=tCxEoskF1505uTI4NoGopgIa2YiiBHAb+Fen74m5/crxXa+YJpFtnudhAIOwzLJ8VBz9mabR/88x+xHBJ6ptRpbPpqXGHssVQS3+IzowfbNSW52wqYEits+MXI+1hepACJs9qZl1NBuSFjuuw8UlS7JzE2fDoW4555PNdCVsOm8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750404063; c=relaxed/simple;
	bh=6CzJTTe8UAFryKwBLx1KIZhMQnCrxcLcO3PkHsiIgZU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Plu+tSWyeVzXijd5aqCuiDOZDWQB/ZfGaZHYjfXqYzl0n/FBI8FwsM6DyUpqfolq3JeCv0XA3MT2H3uB6nHTQKIlXe6s3cSWs7SYUeir9qXfL0V1NvTG9WVkK5oaipTv0ApZSiWRa04xWd74fvPv5lUJxM2RML/BepcpovJLUBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TuHKoPlV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F8D0C4CEE3;
	Fri, 20 Jun 2025 07:21:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750404063;
	bh=6CzJTTe8UAFryKwBLx1KIZhMQnCrxcLcO3PkHsiIgZU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TuHKoPlVPfTOsB/WQtYJf5zlBtolTQkUCL6Vi4nZPFzAv37NK4dAVgTRiuCfkzRqV
	 jjtylnUGD/2CJo8wk/7C9QvKljadw6O870GPa7Lrt5pKVHsJztSDTV9i+Fewi+kKpV
	 X30rJLlfKQUB8dhsA75W7VbzieK73uZDwwNgEyrBvdEBwYTh/mHEgp6ZIlKv2RwWmm
	 nyCHXn7M0TZoyq0yCD1BXnBjEtejLsDkcc0AO5rgyEPPhXDIXJOtnirC7SnBdPyJoK
	 0yGvbGIpVruZGDZ2VkClfdsJNec3LRbEMLroF2nxq7hu82CpTcc2zw1J2WuCYOROR5
	 ++bCX09pEZ6Zg==
Date: Fri, 20 Jun 2025 09:21:00 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Hardik Garg <hargar@linux.microsoft.com>
Cc: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org, 
	decui@microsoft.com, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	devicetree@vger.kernel.org, linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org, 
	ssengar@linux.microsoft.com, hargar@microsoft.com, apais@microsoft.com
Subject: Re: [PATCH v4 1/2] dt-bindings: microsoft: Add vmbus
 message-connection-id property
Message-ID: <20250620-strange-rough-gharial-d2bc73@kuoka>
References: <1750374395-14615-1-git-send-email-hargar@linux.microsoft.com>
 <1750374395-14615-2-git-send-email-hargar@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1750374395-14615-2-git-send-email-hargar@linux.microsoft.com>

On Thu, Jun 19, 2025 at 04:06:34PM GMT, Hardik Garg wrote:
> Document the microsoft,message-connection-id property for VMBus DeviceTree
> node. This property allows specifying the connection ID used for

What is a connection ID and why it cannot be inferred from existing
system API?

> communication between host and guest.
> 
> Signed-off-by: Hardik Garg <hargar@linux.microsoft.com>
> ---
> v3: https://lore.kernel.org/all/6a92ca86-ad6b-4d49-af6e-1ed7651b8ab8@linux.microsoft.com
> v2: https://lore.kernel.org/all/096edaf7-cc90-42b6-aff4-c5f088574e1e@linux.microsoft.com
> v1: https://lore.kernel.org/all/6acee4bf-cb04-43b9-9476-e8d811d26dfd@linux.microsoft.com
> ---
>  Documentation/devicetree/bindings/bus/microsoft,vmbus.yaml | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/bus/microsoft,vmbus.yaml b/Documentation/devicetree/bindings/bus/microsoft,vmbus.yaml
> index 0bea4f5287ce..615b48bd6a8b 100644
> --- a/Documentation/devicetree/bindings/bus/microsoft,vmbus.yaml
> +++ b/Documentation/devicetree/bindings/bus/microsoft,vmbus.yaml
> @@ -17,6 +17,14 @@ properties:
>    compatible:
>      const: microsoft,vmbus

There's a reason why you have here generic property - this is generic
and/or discoverable and/or whatever software interface. Adding now more
properties, just because you made it generic, is not the way.

>  
> +  microsoft,message-connection-id:
> +    description: |

Drop |

> +      VMBus message connection ID to be used for communication between host and
> +      guest. If not specified, defaults to VMBUS_MESSAGE_CONNECTION_ID_4 (4) for
> +      protocol version VERSION_WIN10_V5 and above, or VMBUS_MESSAGE_CONNECTION_ID
> +      (1) for older versions.

Missing constraints, defaults, if this stays, but frankly speaking it
looks really not appropriate, considering lack of any explanation in the
binding or in commit msg.


Best regards,
Krzysztof


