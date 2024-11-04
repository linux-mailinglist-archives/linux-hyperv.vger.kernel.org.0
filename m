Return-Path: <linux-hyperv+bounces-3249-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D32E9BAA4A
	for <lists+linux-hyperv@lfdr.de>; Mon,  4 Nov 2024 02:26:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0B80A281395
	for <lists+linux-hyperv@lfdr.de>; Mon,  4 Nov 2024 01:26:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EE82156665;
	Mon,  4 Nov 2024 01:26:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="mwumFI9E"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8110926AF6;
	Mon,  4 Nov 2024 01:26:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730683584; cv=none; b=Yqo/1fMW3YqhYxCxYQYi9kCPOHiHzKN6x8mQUTTZV1fokqVNPxMI5EeW4Fhymn9OBtc3Mfokt+B0ei4dj1NZjT2E7sekpYMiufNA68XBIlX2LP0jon7WQuYflJ++XclEpYq7chAM7oYKa8UkVHLXlfcXqlZae1EAUiH8NQod+8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730683584; c=relaxed/simple;
	bh=KB98Un7mQM2y6mVpx6JRHoz0b/BTC5JATt4FtI33v0U=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=J1qx4+o9RB1t+YwBEwDSBgE9rvEfx/fmKVaCex32XUaVnDNo0SUjGLqzQYaQMKq/P5P/U9JIpcR/xCvWIUMPj8BdzUPVzliDl99s/ZS+ahJbMbVkZPSCP9mkqd9oB2vayK2fFv0FvSVRjcyL+TLbbdauCaW8VracaZ6g4D7WP50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=mwumFI9E; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4A3Nehke026061;
	Mon, 4 Nov 2024 01:25:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=iMh8eF
	HecHacE2bhwoTpB2hk6AqM865un55dFnhq1os=; b=mwumFI9ENq4rcML09znikW
	bSKfPSoLpGiPwIVPNb+PTU/Z9iu2uh9/7IsfcbZ2541kn+9Pa1KaH43261DTcInL
	pJ3rcjIjJBQ6fzmxg8ns9KWzD3Uc3+devvxJHHrJ42w5VT1xxl9HouMu+BQwVlnS
	K2EOVqA7F3PdpEO8mnuj2Rhej4k3uU44TrsNEMww2Kr5veoMrGZuLbZbKka3UhPP
	mwbaM/NWU4zi15DYpX7ZFZ8FllhKhAH1hafqawYZz+WNlB3YXAWAHnoeUXpPgJZB
	zuibf6jNbtRmEvDez5JdDKt6c/vHhZGRrKjxNUpwH+T/eFfpc6soYKoS+By8HCdA
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 42pk2106hs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 04 Nov 2024 01:25:30 +0000 (GMT)
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 4A41PT6m022592;
	Mon, 4 Nov 2024 01:25:29 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 42pk2106hq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 04 Nov 2024 01:25:29 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 4A3J0Iri019625;
	Mon, 4 Nov 2024 01:25:28 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 42p0mj1840-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 04 Nov 2024 01:25:28 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 4A41PQfB13566404
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 4 Nov 2024 01:25:26 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8B46020043;
	Mon,  4 Nov 2024 01:25:26 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0C94C20040;
	Mon,  4 Nov 2024 01:25:26 +0000 (GMT)
Received: from ozlabs.au.ibm.com (unknown [9.63.197.14])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  4 Nov 2024 01:25:26 +0000 (GMT)
Received: from jarvis.ozlabs.ibm.com (unknown [9.150.11.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ozlabs.au.ibm.com (Postfix) with ESMTPSA id 95503602B8;
	Mon,  4 Nov 2024 12:25:07 +1100 (AEDT)
Message-ID: <3b8312490c668a99b2a89667b7d1cbdf2019b885.camel@linux.ibm.com>
Subject: Re: [PATCH v2 06/10] sysfs: treewide: constify attribute callback
 of bin_attribute::mmap()
From: Andrew Donnellan <ajd@linux.ibm.com>
To: Thomas =?ISO-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>,
        Greg
 Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki"
 <rafael@kernel.org>,
        Bjorn Helgaas	 <bhelgaas@google.com>,
        Srinivas
 Kandagatla <srinivas.kandagatla@linaro.org>,
        Davidlohr Bueso
 <dave@stgolabs.net>,
        Jonathan Cameron <jonathan.cameron@huawei.com>,
        Dave
 Jiang	 <dave.jiang@intel.com>,
        Alison Schofield
 <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ira
 Weiny <ira.weiny@intel.com>,
        Alex Deucher	 <alexander.deucher@amd.com>,
        Christian =?ISO-8859-1?Q?K=F6nig?=	 <christian.koenig@amd.com>,
        Xinhui Pan
 <Xinhui.Pan@amd.com>, David Airlie	 <airlied@gmail.com>,
        Simona Vetter
 <simona@ffwll.ch>,
        Dennis Dalessandro	
 <dennis.dalessandro@cornelisnetworks.com>,
        Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky	 <leon@kernel.org>,
        Tudor Ambarus
 <tudor.ambarus@linaro.org>,
        Pratyush Yadav	 <pratyush@kernel.org>,
        Michael
 Walle <mwalle@kernel.org>,
        Miquel Raynal	 <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Naveen Krishna Chatradhi <naveenkrishna.chatradhi@amd.com>,
        Carlos Bilbao	
 <carlos.bilbao.osdev@gmail.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Ilpo
 =?ISO-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        "David E. Box"
 <david.e.box@linux.intel.com>,
        "James E.J. Bottomley"	
 <James.Bottomley@HansenPartnership.com>,
        "Martin K. Petersen"	
 <martin.petersen@oracle.com>,
        Richard Henderson
 <richard.henderson@linaro.org>,
        Matt Turner <mattst88@gmail.com>,
        Frederic
 Barrat <fbarrat@linux.ibm.com>,
        Arnd Bergmann <arnd@arndb.de>, Logan
 Gunthorpe <logang@deltatee.com>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang	 <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>,
        Dexuan Cui	 <decui@microsoft.com>
Cc: Dan Williams <dan.j.williams@intel.com>, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-cxl@vger.kernel.org,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-rdma@vger.kernel.org, linux-mtd@lists.infradead.org,
        platform-driver-x86@vger.kernel.org, linux-scsi@vger.kernel.org,
        linux-usb@vger.kernel.org, linux-alpha@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-hyperv@vger.kernel.org
Date: Mon, 04 Nov 2024 12:24:55 +1100
In-Reply-To: <20241103-sysfs-const-bin_attr-v2-6-71110628844c@weissschuh.net>
References: <20241103-sysfs-const-bin_attr-v2-0-71110628844c@weissschuh.net>
	 <20241103-sysfs-const-bin_attr-v2-6-71110628844c@weissschuh.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.1 (3.54.1-1.fc41) 
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: IVwbyg3makWwSzhu8aJUQIgu4AbnB-xA
X-Proofpoint-ORIG-GUID: b4TgSoTo26XoqfO5DuvsB1xx-Da_599i
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 spamscore=0
 clxscore=1011 suspectscore=0 impostorscore=0 bulkscore=0 malwarescore=0
 priorityscore=1501 adultscore=0 lowpriorityscore=0 mlxlogscore=906
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2411040007

On Sun, 2024-11-03 at 17:03 +0000, Thomas Wei=C3=9Fschuh wrote:
> The mmap() callbacks should not modify the struct
> bin_attribute passed as argument.
> Enforce this by marking the argument as const.
>=20
> As there are not many callback implementers perform this change
> throughout the tree at once.
>=20
> Signed-off-by: Thomas Wei=C3=9Fschuh <linux@weissschuh.net>

Acked-by: Andrew Donnellan <ajd@linux.ibm.com> # ocxl

--=20
Andrew Donnellan    OzLabs, ADL Canberra
ajd@linux.ibm.com   IBM Australia Limited

