Return-Path: <linux-hyperv+bounces-6391-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D620B118A9
	for <lists+linux-hyperv@lfdr.de>; Fri, 25 Jul 2025 08:49:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4E67E3A5AA2
	for <lists+linux-hyperv@lfdr.de>; Fri, 25 Jul 2025 06:48:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F7052882C1;
	Fri, 25 Jul 2025 06:49:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="qDtxYrmW"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.15.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F7F326CE08;
	Fri, 25 Jul 2025 06:48:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753426141; cv=none; b=sTrhneG+09hsWTG1hCnMDYRzJTBY0BE0sbpoj5KW9z7daOGtBp9r3nFjlXB1DoZIrV739kYXFtRu8cM7h7ev/Hg4hKNIDfdIiuyZdgQmjgX/TVwvTvadIfhGTECxGS07hHFPRNihS7vcfkt8aI/YMHtDbaAwERXou0np1aQz8Y8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753426141; c=relaxed/simple;
	bh=EhsjRfFYi3TvNj8OhAOcDUzuJCghcHQBsGT8pu3uvtE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hAUcL4QLenZtXrrYObSX4GlSaMdOaS8pP0OThLm8plidFFiTTC07jW4yAUoyG4mH93baFcUbQzLcpT5xIq8WJe0c2rOT5Dv5KDEyJKXXnrej3LoI4f3rLdlFdL7LPDEKLden8cJ1y4G4O1DzPoctK9NTXzI+UXNIu1G2HrhZdr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=qDtxYrmW; arc=none smtp.client-ip=212.227.15.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1753426109; x=1754030909; i=markus.elfring@web.de;
	bh=EhsjRfFYi3TvNj8OhAOcDUzuJCghcHQBsGT8pu3uvtE=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=qDtxYrmW81a2M89hMT63Tl7fPQwA8J74fMeP9qf/cNRvGdQCgoG/vjNbQqCOCnnH
	 CSyxb9MV0DEg7G4u5JxeYNWy1K0NXKLGIscP0DNzVceVBiojW/ZSbSYuI1e91civ9
	 PRZB3mVIfjUvh3P0HorP/+QxmEoiAETxuSOR8P4LpRV/KZvK7KHVYPkpjvbhPLN6u
	 pFGPQGZUEat+ljlb/1pz37Htj+WUwkH+pQY+pnlQNKc+4wQv5+AtfEoTL5PfT2T+D
	 eOYjDS2ZLOzsgPfBOYZvPnH+XSIrsJWpM87YYShRwmCRP06BC/e2DsOy1kLv0EQrh
	 2qDRCfhiWVeAF9yIKA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.69.216]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MjBRZ-1uBNmb46VR-00job7; Fri, 25
 Jul 2025 08:48:29 +0200
Message-ID: <c43d27e6-7953-478a-89d7-c08576443cac@web.de>
Date: Fri, 25 Jul 2025 08:48:08 +0200
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [v6 0/2] Drivers: hv: Introduce new driver - mshv_vtl
To: Naman Jain <namjain@linux.microsoft.com>,
 "K . Y . Srinivasan" <kys@microsoft.com>,
 Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>,
 Dexuan Cui <decui@microsoft.com>, Michael Kelley <mhklinux@outlook.com>,
 linux-hyperv@vger.kernel.org
Cc: Roman Kisel <romank@linux.microsoft.com>,
 Anirudh Rayabharam <anrayabh@linux.microsoft.com>,
 Saurabh Sengar <ssengar@linux.microsoft.com>,
 Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>,
 Nuno Das Neves <nunodasneves@linux.microsoft.com>,
 Alok Tiwari <alok.a.tiwari@oracle.com>, "Paul E. McKenney"
 <paulmck@kernel.org>, LKML <linux-kernel@vger.kernel.org>
References: <20250724082547.195235-1-namjain@linux.microsoft.com>
 <fe2487c2-1af1-49e2-985e-a5b724b00e88@web.de>
 <558412b1-d90a-486a-8af4-f5c906c04cca@linux.microsoft.com>
 <8cfe5678-b8c0-471c-8ad2-2c232c4bbc24@web.de>
 <5160e0ab-f588-481c-9585-98b6f2944407@linux.microsoft.com>
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <5160e0ab-f588-481c-9585-98b6f2944407@linux.microsoft.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:8wSr+TTFmQDknorCUMFO0KR5Qq7cojlV63KXCiNK89SPimqJi7n
 1W3EPfj6/AJiQ6Lq7EGtbfFUkVGjx2T01+ZEoAO2wDzPuHbAbHFxZzRdMUM98UQqSa2XEcm
 /0Q7kFfRnX0zO8AXUbWJhHbduO27Pv3ZvaduCQv/aSiVoGAxT5G9TkQiv2UEQiJ4qAe3zh3
 EC1jxMZ0E17ZGOlk5jX1Q==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:wW7Y7hudLko=;C1Qi+IciQncNCGvridVPVpyZNwI
 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

> I have one other usage of rcu_read_lock/unlock in the code, which I feel=
 is=C2=A0fine=C2=A0in=C2=A0its=C2=A0current=C2=A0form.

You may use another lock guard accordingly, don't you?
https://elixir.bootlin.com/linux/v6.16-rc7/source/include/linux/rcupdate.h=
#L1155-L1167

Regards,
Markus

