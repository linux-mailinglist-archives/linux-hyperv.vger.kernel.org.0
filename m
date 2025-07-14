Return-Path: <linux-hyperv+bounces-6203-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FC41B03849
	for <lists+linux-hyperv@lfdr.de>; Mon, 14 Jul 2025 09:48:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D8A4B172BB2
	for <lists+linux-hyperv@lfdr.de>; Mon, 14 Jul 2025 07:48:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2C2F23506F;
	Mon, 14 Jul 2025 07:48:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="UjwWrKuM"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7405E234984;
	Mon, 14 Jul 2025 07:48:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752479334; cv=none; b=mASaNDx4sQopNCTAub7Pb3MzyMRkX73y8up7McOXJqKoopbjwToMuv/lhqQAq7ctVAUjlNF6EEEod1aash3ijDRpgTTBOxgyHGfhA1kxsBUiRGWjK7iG+NPkuRmOC5sgOd6bAH7ptqGffLPs97HKuh7MSTalG84yewxnt3wNIWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752479334; c=relaxed/simple;
	bh=nuuLlOVlNodzu/Axt3T1Z83fbyu4TP/XpSIuqgqPUrs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=Co/fwP16cei5U5jTgZf3AghxrDWAhxW+9qDUtVOHYtTO8xn5gyPuj9RZLzPJbGkr4/UAd1QA49FY4N+EYEDd+Y4W2X7xWva/0+KNLvuZ1okfPSR8pHVJX6tPrdF/PB4lY9A8KWpIBWwSnLrr3iGLHvp5HssmLfUBs24bidVGPfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=UjwWrKuM; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1158)
	id CBE14201BA10; Mon, 14 Jul 2025 00:48:47 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com CBE14201BA10
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1752479327;
	bh=lh7OvjxUiWbA9fCP4WGF/thBMgI0OVrgL7zIDa8EjXs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=UjwWrKuMn2J8yaJ5VSUTFtlQMDMxlzOO1Ga4sTrbHPJ2cjNj/uRzoDwcubCacpylX
	 PpUi2p/sY9rvnQlMH2TSnl0OEqVWOvgDcSWq/nH6F5Flbv6BUkrP6FQyPDqSu7P0+F
	 u0ZB3gMU6QoBnNGQ5uMODBGiHnm9ylBBB4ij6NBk=
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
Date: Mon, 14 Jul 2025 00:48:47 -0700
Message-Id: <1752479327-19753-1-git-send-email-hargar@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <20250620-strange-rough-gharial-d2bc73@kuoka>
References: <20250620-strange-rough-gharial-d2bc73@kuoka>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>

Thank you for your review, Krzysztof. I apologize for the delay in 
my response.

>> What is a connection ID and why it cannot be inferred from existing
>> system API?

The connection-id determines which hypervisor communication channel the
guest should use to talk to the VMBus host. Reading from DeviceTree allows
platforms to specify their preferred communication channel, making it more
flexible (I will add this detail in the commit message). Presently, this
value is hardcoded and there is no existing API to read it.

>> There's a reason why you have here generic property - this is generic
>> and/or discoverable and/or whatever software interface. Adding now more
>> properties, just because you made it generic, is not the way.

Presently the value is hardcoded and we want to provide a functionality to
the user to specify their prefered communication channel. This is a
virtualized hardware property for us.

>> Drop |

I will remove "|".

>> Missing constraints, defaults, if this stays, but frankly speaking it
>> looks really not appropriate, considering lack of any explanation in the
>> binding or in commit msg.

I will add constraints, and defaults.

Please let me know if there are any other issues that I should fix with
the next version of the patch and thank you again for the review.




Regards,
Hardik

