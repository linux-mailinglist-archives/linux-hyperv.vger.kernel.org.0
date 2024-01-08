Return-Path: <linux-hyperv+bounces-1384-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D10BD826ABE
	for <lists+linux-hyperv@lfdr.de>; Mon,  8 Jan 2024 10:33:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2FC77B20DEB
	for <lists+linux-hyperv@lfdr.de>; Mon,  8 Jan 2024 09:33:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D102D2FF;
	Mon,  8 Jan 2024 09:33:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=deller@gmx.de header.b="G+Zk9ux5"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A4551426D;
	Mon,  8 Jan 2024 09:33:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
	t=1704706409; x=1705311209; i=deller@gmx.de;
	bh=B91dkGZkhI5I6MrAdfx6C1xz2e+7x2w4wYdu9BniE20=;
	h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
	 In-Reply-To;
	b=G+Zk9ux5chVXa/6rJuy46xvadWZneQuJs7h5aRvZGaegY3vrxSXGPFai3yFK+X/l
	 W8t5qoXY/rQZQ4/w3Zfu2lAAfsvmUt12skRXIyCVjCYKQocgLE+lgXv/jzznNDB2E
	 JMRudAZ6tQ9f8ojdWEmX7AAhKLaZNj8exX9KRFBkbRVxdbcnQ+pyxz+GU3ERxcfmO
	 vghbP9CURD1/z6GTeCsGEZLT03TfED3ZahRiEvvN92EtGMyowf+cICvALDZRJ1ezW
	 VjcCUKLnFDwwqEtsAYOKZkjIQGBZTlPRPM7ebg7CBQ7i3OuV25QlPEjpCS3/Odukw
	 ZWZ4Qf/MTn7xtYOW7g==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.20.55] ([94.134.148.84]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1N6sn7-1r7Vbi0EFb-018K1U; Mon, 08
 Jan 2024 10:33:29 +0100
Message-ID: <4095003c-20a5-45af-8765-d772cd054f0b@gmx.de>
Date: Mon, 8 Jan 2024 10:33:28 +0100
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] drm/hyperv: Remove firmware framebuffers with
 aperture helper
Content-Language: en-US
To: Javier Martinez Canillas <javierm@redhat.com>,
 Thomas Zimmermann <tzimmermann@suse.de>, drawat.floss@gmail.com,
 decui@microsoft.com, wei.liu@kernel.org, haiyangz@microsoft.com,
 kys@microsoft.com, daniel@ffwll.ch, airlied@gmail.com
Cc: linux-hyperv@vger.kernel.org, linux-fbdev@vger.kernel.org,
 dri-devel@lists.freedesktop.org
References: <20240103102640.31751-1-tzimmermann@suse.de>
 <20240103102640.31751-2-tzimmermann@suse.de>
 <87a5pgdvll.fsf@minerva.mail-host-address-is-not-set>
From: Helge Deller <deller@gmx.de>
Autocrypt: addr=deller@gmx.de; keydata=
 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
In-Reply-To: <87a5pgdvll.fsf@minerva.mail-host-address-is-not-set>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Ovg2O8J5M3AOSM/vZFPHDgtkX3D/xvyImfjoBYLjdx916W4W8Gl
 E/KT40SX52KPnbKk3aA23DYEZpEsrM+uvIyHA398GbZdRstiM2Fsd2myhG36BK8IrSF/8zq
 EPvldWvRJ/WMu6nDXBh0BngdX7/LQmAtHDQniKlLMTUDSWd/VxfcycmINF0495JEGE4ZoaR
 uAwIUOP54ZHopc6eanqfQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:75kICWzAk4Y=;peWUIQcD9PynF7OMHl92dYNXYqr
 pLB8HBoTQrAqU9lnyMK08vGc0svEelqnoOglX+4qhZSgJ6scmJuNIAYqFUOiTGIdUqmb1dEp7
 mRMieFGRhE0SrmqntGvEWQfu0wfjG82uNb6Apz7n97qLlvosqxo18qDRaeZY3o0zs0TNQjKTZ
 vBgjEPFBeXJUQhsaFVc6I09/Z/9BNaKh6HJ2IDJxndXumTs0JPIQejCs931Dq1Tk23HW+kBwR
 W7kEmYBM403s577wVe8d8iqhCrZLIkMEGqs5w4dKwoi5cvX3tVEAmCtKJ+up74CBC/ojo+kkG
 4CZrxz97m6YbuvqguJAM7GkJRBmpKk7bJIwXElfClhHQ4qNkkx8bUj7l3i5kNGOoKmDITXR9G
 k4GqFtdsHa08OW86DYLqaQUZaflyg6SKz4eFkthL9HtXEJyEYvq7kbTYzCU/uG4VIXL0ynn69
 HOBNqoiQ+1mxpWCA63vEIi7rCgiuIiCf3/nwGp6yzCeGdCVq2Tj/6yYvjb6KAQv9wDgriXBQt
 eIir6s6RTwikLdyi48dnBZZTSpMGiZEZ96iJNztirfg1gGGcBK7KmNugbxWm7ln04OLDdkEp/
 44SAFhF7NwVRifoWP9ytF8tZEgCyo5Bi37qN5vO008YKmb/cI3V9kxJO/WlXd/1FBmPDHj66f
 WuHIyp4IdbKBNdr0EeoGIRJtBNoHa0fliISsqDtWOhc/svfGsBV52iJR8u1cSOmKkQnTrT9Zh
 3pSGCZczy33bsKMuXhJ9be02B8h+ALqbX0aVtDAcDbbvjztb3/GyTxD/5+gv+THrPe6JUx4A+
 ieIVjI9t37QwuaEwpH/0cWDoyRKXoCavOqbCw4b8FRiNJlJ7g4pbqzcYWNqTJDNNhliaYfxxY
 VqwlZh42IO7Ltz2gaPGFCFDvN7QmIqfCNlmxzrzIf43i0OgKVv0QYJOLQC+pMxKPOELliIa14
 gisMSqhIunIYgloPpXkJ1sZmI5c=

On 1/8/24 10:26, Javier Martinez Canillas wrote:
> Thomas Zimmermann <tzimmermann@suse.de> writes:
>
> Hello Thomas,
>
>> Replace use of screen_info state with the correct interface from
>> the aperture helpers. The state is only for architecture and firmware
>> code. It is not guaranteed to contain valid data. Drivers are thus
>> not allowed to use it.
>>
>> For removing conflicting firmware framebuffers, there are aperture
>> helpers. Hence replace screen_info with the correct function that will
>> remove conflicting framebuffers for the hyperv-drm driver. Also
>> move the call to the correct place within the driver.
>>
>> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
>> ---
>
> Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>

Series applied to fbdev git tree.

Thanks,
Helge


