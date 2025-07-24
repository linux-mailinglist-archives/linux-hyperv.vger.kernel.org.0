Return-Path: <linux-hyperv+bounces-6376-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AA71B1051A
	for <lists+linux-hyperv@lfdr.de>; Thu, 24 Jul 2025 11:00:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3666F5A3DCF
	for <lists+linux-hyperv@lfdr.de>; Thu, 24 Jul 2025 08:58:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D79EB2750F3;
	Thu, 24 Jul 2025 08:56:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="vet2F8fp"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mout.web.de (mout.web.de [217.72.192.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAFB41A08BC;
	Thu, 24 Jul 2025 08:56:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.72.192.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753347415; cv=none; b=YDjFS/ww0tAtIQUDlPTH3Xw/QS28wZCWSvTCrAtUc0nlnYRES3jvFkyfIjGHK2Wntg4xcdJGR13vkCosVb7bh1Is2dQE2ZqkmvwK3vfHnPYhdzVu/71hVJqi5gqgibdHvV718PvN/akPpIzDVYVDQIMweLtV4mX+dnY2nHi8zeY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753347415; c=relaxed/simple;
	bh=Bbha3Rhebr5YOQs6+X3btQ4GSrRGICglb4AMbsl77X4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uufMi3bWxcrzCxxT4qQHbWd4dpRDKkp95DfJX7nXeWJU0gAphD28Q0L0Kpur0VTvt5gW6//UAShiaV+PzOUF7lw9gCRseiWm2qlqv0uPjio3NTWcDpcMU3JcNwEIUbVo4cNMFpSGI44vzCli0508xt4zy4KegLX0fN7A+kmkrjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=vet2F8fp; arc=none smtp.client-ip=217.72.192.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1753347404; x=1753952204; i=markus.elfring@web.de;
	bh=Bbha3Rhebr5YOQs6+X3btQ4GSrRGICglb4AMbsl77X4=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=vet2F8fpiclPsn8ABABSIZ/p4QhHei/tW4k56GHrre49aUkph+C+kFCn12HJjjy4
	 xftYLCDwDNG0OTu5njVeki75wVVrs/5/nkyh/3HsKH2Y2yqiRU/o2hgGcx6corVNF
	 LmgIEbo3zQVDO6CE7Rmg/qZwZH/V3I2Kt3VfPfe24ygWubvhMw2k8S/aUeBa8AwoP
	 CJ8XKhqMYX8GOWY8sAYlL130d51/602N1Mj5luIJAzeCKbTR1R1PeLyYPZBROf1uW
	 dg4wPgcWMpbYV9dn5FGPjIc7kWfcI5+iUKyBSw4tJi+aboOm+JdURjGD30C6EGH5l
	 kAIvHJy4hRZbKQCEuw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.92.250]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1M5j1c-1um0d424ba-00G7wU; Thu, 24
 Jul 2025 10:56:44 +0200
Message-ID: <fe2487c2-1af1-49e2-985e-a5b724b00e88@web.de>
Date: Thu, 24 Jul 2025 10:56:19 +0200
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 0/2] Drivers: hv: Introduce new driver - mshv_vtl
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
 Alok Tiwari <alok.a.tiwari@oracle.com>, linux-kernel@vger.kernel.org
References: <20250724082547.195235-1-namjain@linux.microsoft.com>
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20250724082547.195235-1-namjain@linux.microsoft.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:CKwTv/JT1FCTwP2FTw9CdS8V7a8YM6/IvzmrpNy51ldpKBbL/Pm
 BWPckWrAOUiKhDqdmrWHDAJ9dBwLG53xmh1rwFBX7z5v6Oy23Tz7n25FVfz2wA1EyteNkPg
 Ta81EkG3NaUVwhPEaRCfW6R7/dcMieY/eWY9k7DAmwBPr3CTLIgAl1EWzcOhz/7i7sKQf9s
 UK9dKBa2ixUkkKZZBSD7w==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:nH6ARGUHu2M=;VUGAJDc/KifeijaFUXJttP0hbYW
 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

=E2=80=A6> Changes since v5:
=E2=80=A6> * Used guard(mutex) for better mutex handling.
=E2=80=A6

Thanks.

Do you see opportunities to extend guard applications for further data str=
uctures?

Regards,
Markus

