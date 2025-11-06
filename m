Return-Path: <linux-hyperv+bounces-7444-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F784C3D83E
	for <lists+linux-hyperv@lfdr.de>; Thu, 06 Nov 2025 22:37:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 337A23A4CB3
	for <lists+linux-hyperv@lfdr.de>; Thu,  6 Nov 2025 21:37:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AB18301711;
	Thu,  6 Nov 2025 21:36:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="ctZ10nOz"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E1AD2E0934;
	Thu,  6 Nov 2025 21:36:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762465017; cv=none; b=qQddRZ36wHJXF01ovEQ0mk/nFGMQaPi3L5Cz2Rb+oFrs1XbCdUZjqHfZX5Us6oOPFGplHbTB02PY/xEHc/DtLXd52M4y/N70BvCImyQ9OLIXQynx7S/PO8LkQH1ODveUFqghhyhXBnIFdjvc+KbzHVdppjrWkgaDAL9dYbh48hs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762465017; c=relaxed/simple;
	bh=oTCfznkhgyFQWLXV098ZqBUkWSDfOrq30RbAqrD6NSY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ca8GB5UVpii0ignj7AD46aAiTXfYgwWp/Tqbl/qgym13csl5DW21FjWD1osO1JI//WYGyyWCN/TiY9p4TK7dgPsPlcjiFyakQO4KzaYR6oSLLrz+/9F58lKy0DQN9oT6Q++oyNZMwkZ/2gdr7FshBiFazfupJyY4/6bjIpj/UF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=ctZ10nOz; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [10.0.0.239] (c-73-83-157-215.hsd1.wa.comcast.net [73.83.157.215])
	by linux.microsoft.com (Postfix) with ESMTPSA id BE5A62118967;
	Thu,  6 Nov 2025 13:36:50 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com BE5A62118967
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1762465011;
	bh=oTCfznkhgyFQWLXV098ZqBUkWSDfOrq30RbAqrD6NSY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=ctZ10nOzij3Pz1jn48BwSqXS8+7RR9k70veKQD+Zvs3BW87cxZJ8x3gaVbNyPmAoh
	 cawfFlR/VLqNS0hZj9KVAzNX9cqhWhaNptBeXH4l0xhwWB7GPHbCNrkvZ35ZwK9/MI
	 3woeNOzcQsKHzvYKjVKckM333+AcLgn7dTN786nM=
Message-ID: <0bda852b-baaa-4167-ad9d-12931e213e29@linux.microsoft.com>
Date: Thu, 6 Nov 2025 13:36:50 -0800
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/2] dt-bindings: microsoft: Add vmbus
 message-connection-id property
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: apais@microsoft.com, cho@microsoft.com, conor+dt@kernel.org,
 decui@microsoft.com, devicetree@vger.kernel.org, haiyangz@microsoft.com,
 hargar@microsoft.com, krzk+dt@kernel.org, kys@microsoft.com,
 linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org, robh@kernel.org,
 ssengar@linux.microsoft.com, wei.liu@kernel.org
References: <6d3b5d1e-de1b-4d3b-ba14-7029c51b8e05@kernel.org>
 <1753395133-26061-1-git-send-email-hargar@linux.microsoft.com>
 <94d3e709-8c8b-40cb-a829-92c2012b4e0a@kernel.org>
 <f6c01c55-8930-459a-baa5-1465c5047b3e@linux.microsoft.com>
 <69ed5b38-830d-46d7-a84b-86787c39df7d@kernel.org>
Content-Language: en-US
From: Hardik Garg <hargar@linux.microsoft.com>
In-Reply-To: <69ed5b38-830d-46d7-a84b-86787c39df7d@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


On 11/4/2025 10:55 PM, Krzysztof Kozlowski wrote:
> On 05/11/2025 02:10, Hardik Garg wrote:
>> Each guest has a private hypervisor mailbox and cannot access any other
>> guest’s communication path. Using an incorrect connection ID does not
>> allow eavesdropping or cause interference — it only results in failed
>> VMBus initialization because the host drops messages sent to an
>> unexpected port. Thus, exposing the correct connection ID to the guest
>> is safe and necessary for correct initialization.
>>
>>> If different values are important for the host, then all guests should
>>> use whatever 0 which will map to different values on host by other means
>>> of your protocol.
>>>
>> Using a fixed value such as 0 for all guests would not work, because the
>> Hyper-V host differentiates between multiple control-plane contexts (for
>> example, VTL0 vs VTL2) using distinct connection IDs. The guest must use
>> the value assigned by the host, as there is no implicit mapping or
>> negotiation protocol to determine it otherwise.
> Sorry, I am not going back to three months old discussion.

I understand your point and I apologize again for the delay in getting
back to you. It took me some time to explore alternative approaches and
verify whether the connection ID could be handled differently, but I’m
now done with that investigation. I’ll make sure to respond in a timely
manner going forward.

>
> Therefore I close this topic for me with: since the actual value does
> not matter for the host - it will discard all messages which are not
> intended to this guest - you can just use value 0 and your hypervisor
> will map to proper port.

The connection ID is managed entirely by the hypervisor and varies
depending on the VM’s configuration (for example, whether the control
plane is in VTL0 or VTL2). There is no existing mapping logic on the
guest side that could translate a constant value like 0 into the correct
port assignment. The host assigns distinct IDs for each configuration,
and the guest must use that specific value to establish the VMBus
control channel correctly.

Could you please confirm if I’m misunderstanding your suggestion about
the mapping mechanism? Without receiving the correct ID from the
hypervisor (via DT or another interface), the guest cannot infer the
right port on its own.

Also, since this thread is quite old, would you prefer that I start a new
thread when I resend the updated patch?

Thanks again for your feedback and patience.




Thanks,
Hardik


