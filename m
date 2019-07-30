Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5F1127B611
	for <lists+linux-hyperv@lfdr.de>; Wed, 31 Jul 2019 01:07:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727301AbfG3XHN (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 30 Jul 2019 19:07:13 -0400
Received: from mail-eopbgr790119.outbound.protection.outlook.com ([40.107.79.119]:24257
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726843AbfG3XHM (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 30 Jul 2019 19:07:12 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b0imMppKzsa6TkZCZVHzMDFAgyX3D2/FXhG5aaD2paZcfxipnywv9Wz6Db6OZ7Wy5XeuPvPUiDzilVYP0AOiDUxRbd94GQESW9IMy6qhRibceIiWfgrVI+rFrhGnS6BukFEcb+Z+TYKLwAxAwHe1S8tX+yi1DIXuXDqKFGKgWozCqXmYhtJiI23ctdvBV/blhqaCGdVzgMJIZzwYbaM8qF4plpkNCBUVK/jsZRa9dhs3n7lho9SswmzJMEx1HGDZflCjNtv6kJMV2dd54cW3HXe12LQJS0N+kEjN8ig/Fjlb8QlJM9esWJiq7+JCsF45X1XsX4cHpfBdBzA1Q46irw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EidYLmBkEOv0H6fWu0ApVIJfr2gv1dkl9SrWiRjg7/c=;
 b=FsYMrFYPcD7l/+5dSViieS39gOp/Cng3iNCzsG/BfZQwsHtR++dpIxCBLg9YmZJxCft3q50efQwhdmMCuOGnwCTe83As61m3uQ/wyjhFPTsWijBXNy51IkWs5hmmjZ3QX7PsEN5VKGR8knaNN7wHzEVviqQvfFaWgmXGIw4wWQ0io5sMHWbOL5xFqiaSNctB7S93jh/5PP0kZODkyLCefAEbrBUtnUK3ROdmY9vKvFmVsGQvO0UDe7HfmLteDHoneXm9ufEapp3Nbb66p4ixpbZhA2G5kOJkFcjYI7FaiKUUj+67PS1nxLAmaNuyuYLzin7GdAAJobSEoY4co10Glg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EidYLmBkEOv0H6fWu0ApVIJfr2gv1dkl9SrWiRjg7/c=;
 b=RQ3kt13UIsVmz9TB6tC3KNbWmvHZX1bzOXIE/mMlCdsCiN83awJc8GzEqrm9W4Zg6T+hUs1Fr/SaKG+sx4fZnHOb1ktKa92krkyK0a0IMwtvoYGZRB7JR2Yws8TSCLutgsuYIWb6k5RFasQ37lZomyqMIzYlC4L7SZ7lFeH/yCQ=
Received: from MWHPR21MB0784.namprd21.prod.outlook.com (10.173.51.150) by
 MWHPR21MB0159.namprd21.prod.outlook.com (10.173.52.17) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2157.2; Tue, 30 Jul 2019 23:07:08 +0000
Received: from MWHPR21MB0784.namprd21.prod.outlook.com
 ([fe80::7de1:e6c1:296:4e82]) by MWHPR21MB0784.namprd21.prod.outlook.com
 ([fe80::7de1:e6c1:296:4e82%5]) with mapi id 15.20.2157.001; Tue, 30 Jul 2019
 23:07:08 +0000
From:   Michael Kelley <mikelley@microsoft.com>
To:     Dexuan Cui <decui@microsoft.com>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>,
        "sashal@kernel.org" <sashal@kernel.org>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        KY Srinivasan <kys@microsoft.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 5/7] Drivers: hv: vmbus: Ignore the offers when resuming
 from hibernation
Thread-Topic: [PATCH 5/7] Drivers: hv: vmbus: Ignore the offers when resuming
 from hibernation
Thread-Index: AQHVNhdI4fE4dJaaXUuVBeGHWvZQDqbj5/pQ
Date:   Tue, 30 Jul 2019 23:07:08 +0000
Message-ID: <MWHPR21MB078481A7C7F65E0297135D41D7DC0@MWHPR21MB0784.namprd21.prod.outlook.com>
References: <1562650084-99874-1-git-send-email-decui@microsoft.com>
 <1562650084-99874-6-git-send-email-decui@microsoft.com>
In-Reply-To: <1562650084-99874-6-git-send-email-decui@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Owner=mikelley@ntdev.microsoft.com;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2019-07-30T23:07:07.0047554Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=a8409ba6-e20e-47d4-80bf-1229879e616a;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Extended_MSFT_Method=Automatic
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=mikelley@microsoft.com; 
x-originating-ip: [24.22.167.197]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1cd22159-9cbe-41bb-f3dd-08d71542a59c
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:MWHPR21MB0159;
x-ms-traffictypediagnostic: MWHPR21MB0159:|MWHPR21MB0159:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MWHPR21MB0159C78777B9A98F5B2E51CCD7DC0@MWHPR21MB0159.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 0114FF88F6
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(376002)(366004)(136003)(396003)(39860400002)(346002)(199004)(189003)(8936002)(8676002)(6506007)(99286004)(3846002)(2201001)(81156014)(81166006)(66946007)(6116002)(2906002)(229853002)(4326008)(102836004)(2501003)(33656002)(66476007)(22452003)(66446008)(66556008)(64756008)(76116006)(14454004)(316002)(68736007)(7696005)(76176011)(110136005)(446003)(25786009)(6246003)(10290500003)(11346002)(8990500004)(478600001)(186003)(486006)(86362001)(1511001)(305945005)(5660300002)(26005)(14444005)(256004)(476003)(66066001)(6436002)(74316002)(10090500001)(71200400001)(71190400001)(53936002)(52536014)(7736002)(55016002)(9686003);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR21MB0159;H:MWHPR21MB0784.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: xQyO/9t2J11n5KOKVdoOZpUiC8QoYRdF9ZbAfm0s9R3he8HEn1vBCPUxeYwWyE/MYkaj41C0FVLWX8DasSeJjvrr+jN9Pau+fn8zLJrjtdIMjCvrO34AxrHlW4twymUgUs29O6Jsblsd6aXiZcF0EnJJrn1kDYckpabc/q9INsQOF5EcZkgR16N17HeU9mGcfJ66ZOtt8p27Qe1OPt4+Txr71YYSxYgoHRMYvCXGnyHCsgArtbLT0bzGmzLtjs1LKXtMGGYbSpR/4hAKcQSalkBYW9/jQM1gmOy8LZdSS4I0kNeKEKTVtFCN9kz8aQ5RlO+htMCfCrO+RxW9sTIcr651wfUQS0UeZw5HcHk5FvsZ3BEmCs0n2+PmBSabGRr7aotrDI0j+KP1VL9Nrddt9DPIGpf7sDLJ2Nv4yrEQloQ=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1cd22159-9cbe-41bb-f3dd-08d71542a59c
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jul 2019 23:07:08.4497
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cjBJD4Kx3pQceundebNh5qvETgWYrEGIzD4hozUoDF66yCkqmMAgQkufF/XP3G1sfDDO9JAA7r9hZQY1VwF8tCwcwZuTkJNLaYZ3ts/k5xA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR21MB0159
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

From: Dexuan Cui <decui@microsoft.com> Sent: Monday, July 8, 2019 10:29 PM
>=20
> When the VM resumes, the host re-sends the offers. We should not add the
> offers to the global vmbus_connection.chn_list again.
>=20
> Added some debug code, in case the host screws up the exact info related =
to
> the offers.
>=20
> Signed-off-by: Dexuan Cui <decui@microsoft.com>
> ---
>  drivers/hv/channel_mgmt.c | 28 +++++++++++++++++++++++++++-
>  1 file changed, 27 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/hv/channel_mgmt.c b/drivers/hv/channel_mgmt.c
> index addcef5..a9aeeab 100644
> --- a/drivers/hv/channel_mgmt.c
> +++ b/drivers/hv/channel_mgmt.c
> @@ -854,12 +854,38 @@ void vmbus_initiate_unload(bool crash)
>  static void vmbus_onoffer(struct vmbus_channel_message_header *hdr)
>  {
>  	struct vmbus_channel_offer_channel *offer;
> -	struct vmbus_channel *newchannel;
> +	struct vmbus_channel *oldchannel, *newchannel;
> +	size_t offer_sz;
>=20
>  	offer =3D (struct vmbus_channel_offer_channel *)hdr;
>=20
>  	trace_vmbus_onoffer(offer);
>=20
> +	mutex_lock(&vmbus_connection.channel_mutex);
> +	oldchannel =3D relid2channel(offer->child_relid);
> +	mutex_unlock(&vmbus_connection.channel_mutex);
> +
> +	if (oldchannel !=3D NULL) {
> +		atomic_dec(&vmbus_connection.offer_in_progress);
> +
> +		/*
> +		 * We're resuming from hibernation: we expect the host to send
> +		 * exactly the same offers that we had before the hibernation.
> +		 */
> +		offer_sz =3D sizeof(*offer);
> +		if (memcmp(offer, &oldchannel->offermsg, offer_sz) =3D=3D 0)
> +			return;

The offermsg contains "reserved" and "padding" fields.  Does Hyper-V
guarantee that all these fields are the same in the new offer after resumin=
g
from hibernation?  Or should a less stringent check be made?  For example,
I could imagine a newer version of Hyper-V allowing a VM that was
hibernated on an older version to be resumed.  But one of the reserved fiel=
ds
might be used in the newer version, and the comparison could fail
unnecessarily.

> +
> +		pr_err("Mismatched offer from the host (relid=3D%d)!\n",
> +		       offer->child_relid);
> +
> +		print_hex_dump_debug("Old vmbus offer: ", DUMP_PREFIX_OFFSET, 4,
> +				     4, &oldchannel->offermsg, offer_sz, false);
> +		print_hex_dump_debug("New vmbus offer: ", DUMP_PREFIX_OFFSET, 4,
> +				     4, offer, offer_sz, false);

The third argument to print_hex_dump() is the rowsize and is specified as m=
ust
be 16 or 32. =20

> +		return;
> +	}
> +
>  	/* Allocate the channel object and save this offer. */
>  	newchannel =3D alloc_channel();
>  	if (!newchannel) {
> --
> 1.8.3.1

