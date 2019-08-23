Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 234F19B7A0
	for <lists+linux-hyperv@lfdr.de>; Fri, 23 Aug 2019 22:25:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389577AbfHWUZH (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 23 Aug 2019 16:25:07 -0400
Received: from mail-eopbgr710136.outbound.protection.outlook.com ([40.107.71.136]:45952
        "EHLO NAM05-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2389571AbfHWUZH (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 23 Aug 2019 16:25:07 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iJlePm7RLZMvp7uJaTSuWAZD6lYLfdCd00OO/HwEB35hu5tNTM4Hz3MMvXEX/hw6tdFIPYwCIlNJQY9y311FPe2KZf5TrhfmmwPIO9ceiXA+K6nj2q6sjhSKAmzEilSUK1F5oSoZ5kZENBFA7XizVsEpCoBp+1CyXZl9/4SIKeR6M44k2uf+/gkoM/F2bozI17HTscswcSLBv5p7yd0qNYuCRyghknWCPHXkCQk3ipZUpmylptW1wTc5trqpVULAIk9nWHdJpWlo5SQhWxdgjdznkzTWSKcU7dLJ32FBWM582cv888fz85XmllhBoEugQhPaVm0UJztfIxkAcAq3JA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wgsZoAKU8iXXU441HwTaOHTfE8iGYjGF0KB6FhAyVYc=;
 b=epaDykyS52Y/xrOuRCheWsGX+LliK3iBhBEdFuRijJkajFHHM6FFJRmUA3Zs888AYs3xqeua7noyN7Qm2y/OmZHIyvnr7Cf+IQvT0Tm3tkv/YwHIjDMYDDleyfVUpITmhIlFI6YXv3Camk3g7+PlWQdGtr04zuFCQux18V07ulgT+ugSV/qZjegV2UuG0bwwuHGLJcl+8O6pLq63GQxz9yjNE/8qoFHqNtYXD7Ma83OiO4KtmltEU4kes9o8GAFrYr1U59Rk2ylq7U98NkZUFFbRRAF+vuO7Ed48L3yfCNJvck1+mKVswJdaqW2tnUGYfL8iYftCxsC7OV7niui7tw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wgsZoAKU8iXXU441HwTaOHTfE8iGYjGF0KB6FhAyVYc=;
 b=D7z8XMVUgkGoGWmx87f/mWMskjOPf9ZtK03VOcc7wcepoi+XxpDJPLDp7gl5SBa2DvDuQKg9Ek06AguI8K3VgKUGEQEQMfImGqrZejJKYqkDjbmDFos78JhBzZWzZqUQywWR4f96HQQeE9/tyUWyecqj2WK9NZQYtOuG6NgzS5k=
Received: from DM5PR21MB0137.namprd21.prod.outlook.com (10.173.173.12) by
 DM5PR21MB0140.namprd21.prod.outlook.com (10.173.173.15) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2220.4; Fri, 23 Aug 2019 20:25:03 +0000
Received: from DM5PR21MB0137.namprd21.prod.outlook.com
 ([fe80::8985:a319:f21:530e]) by DM5PR21MB0137.namprd21.prod.outlook.com
 ([fe80::c437:6219:efcc:fb8a%8]) with mapi id 15.20.2220.000; Fri, 23 Aug 2019
 20:25:03 +0000
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
Subject: RE: [PATCH v3 12/12] Drivers: hv: vmbus: Resume after fixing up old
 primary channels
Thread-Topic: [PATCH v3 12/12] Drivers: hv: vmbus: Resume after fixing up old
 primary channels
Thread-Index: AQHVVvnhnZYV8iEJF0ORPS4BQ7lYm6cJMgUQ
Date:   Fri, 23 Aug 2019 20:25:02 +0000
Message-ID: <DM5PR21MB01370691E881D59773B9EF60D7A40@DM5PR21MB0137.namprd21.prod.outlook.com>
References: <1566265863-21252-1-git-send-email-decui@microsoft.com>
 <1566265863-21252-13-git-send-email-decui@microsoft.com>
In-Reply-To: <1566265863-21252-13-git-send-email-decui@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Owner=mikelley@ntdev.microsoft.com;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2019-08-23T20:25:01.1543000Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=ed8325f3-7994-47a0-9ecc-2c1fc987ecca;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Extended_MSFT_Method=Automatic
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=mikelley@microsoft.com; 
x-originating-ip: [24.22.167.197]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c8f073f4-1e54-44ae-dfe1-08d72807fa9e
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600166)(711020)(4605104)(1401327)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:DM5PR21MB0140;
x-ms-traffictypediagnostic: DM5PR21MB0140:|DM5PR21MB0140:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM5PR21MB01407F39E3FD7548ACDFB95CD7A40@DM5PR21MB0140.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 0138CD935C
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(376002)(39860400002)(366004)(136003)(396003)(346002)(199004)(189003)(305945005)(26005)(446003)(11346002)(14444005)(81156014)(8676002)(102836004)(6506007)(256004)(81166006)(186003)(486006)(476003)(7696005)(7736002)(76176011)(22452003)(4326008)(74316002)(6246003)(3846002)(6116002)(9686003)(10090500001)(55016002)(1511001)(8990500004)(2906002)(66066001)(6436002)(53936002)(5660300002)(14454004)(110136005)(316002)(86362001)(478600001)(2201001)(66476007)(71200400001)(71190400001)(76116006)(66556008)(10290500003)(66946007)(99286004)(25786009)(64756008)(33656002)(66446008)(2501003)(8936002)(229853002)(52536014);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR21MB0140;H:DM5PR21MB0137.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: /hXv5Oc/lqKv5+Ka+T8AgRzyU0fFzVcnKOmNeT3de2vDacxwd5gijvPKZye+ZqUVGFv8W50Z3UsFipGyy/767RPO+IIfAqcgVpYWPAWpYiL7sypO7nYQ+zu+BJieW5mn+5JZy/cnIdjIktnSvguYh0MeR0T1GJf330fAA40SODGuqDeDmMVKJ9nvyxr0k16nlgq5ScborERs3S99YclYxBjXYlWitbuxctbClNq9zwswv+k2H/CCpRiVSGPn/hv6t3pgx3CvDXNcMlLAElovjlgfJBterAMbaH0wuFBi4ZptoLRpL6FQ8Hcwmd4NcNVv1BkAQV6dhaR87Z5Bch9VWuU6yl4RFsaO3ubkogMnpWbHAST0GwUz98BC4o2qQw6/uwXfGGDJ3Pa36drO0Kpu4SwPliO2NVN05NHdS0qsqTg=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c8f073f4-1e54-44ae-dfe1-08d72807fa9e
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Aug 2019 20:25:03.0062
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rBwIMEeqCakkQtuOYrCsrt3b2ZCeWDxN5QYiAeloZhAj8sRYdVjLcmRIrKwRgeKWHyAbllOwBimBC5RSAv3gzHkR5EvT1LGGB0oDcckDCIs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR21MB0140
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

From: Dexuan Cui <decui@microsoft.com> Sent: Monday, August 19, 2019 6:52 P=
M
>=20
> When the host re-offers the primary channels upon resume, the host only
> guarantees the Instance GUID  doesn't change, so vmbus_bus_suspend()
> should invalidate channel->offermsg.child_relid and figure out the
> number of primary channels that need to be fixed up upon resume.
>=20
> Upon resume, vmbus_onoffer() finds the old channel structs, and maps
> the new offers to the old channels, and fixes up the old structs,
> and finally the resume callbacks of the VSC drivers will re-open
> the channels.
>=20
> Signed-off-by: Dexuan Cui <decui@microsoft.com>
> ---
>  drivers/hv/channel_mgmt.c | 76 +++++++++++++++++++++++++++++++++++------=
------
>  drivers/hv/connection.c   |  2 ++
>  drivers/hv/hyperv_vmbus.h | 14 +++++++++
>  drivers/hv/vmbus_drv.c    | 17 +++++++++++
>  include/linux/hyperv.h    |  3 ++
>  5 files changed, 93 insertions(+), 19 deletions(-)
>=20
> @@ -875,12 +913,21 @@ static void vmbus_onoffer(struct
> vmbus_channel_message_header *hdr)
>  		atomic_dec(&vmbus_connection.offer_in_progress);
>=20
>  		/*
> -		 * We're resuming from hibernation: we expect the host to send
> -		 * exactly the same offers that we had before the hibernation.
> +		 * We're resuming from hibernation: all the sub-channel and
> +		 * hv_sock channels we had before the hibernation should have
> +		 * been cleaned up, and now we must be seeing a re-offered
> +		 * primary channel that we had before the hibernation.
>  		 */
> +
> +		WARN_ON(oldchannel->offermsg.child_relid !=3D INVALID_RELID);
> +		/* Fix up the relid. */
> +		oldchannel->offermsg.child_relid =3D offer->child_relid;
> +
>  		offer_sz =3D sizeof(*offer);
> -		if (memcmp(offer, &oldchannel->offermsg, offer_sz) =3D=3D 0)
> +		if (memcmp(offer, &oldchannel->offermsg, offer_sz) =3D=3D 0) {
> +			check_ready_for_resume_event();
>  			return;
> +		}
>=20
>  		pr_debug("Mismatched offer from the host (relid=3D%d)\n",
>  			 offer->child_relid);
> @@ -890,6 +937,11 @@ static void vmbus_onoffer(struct
> vmbus_channel_message_header *hdr)
>  				     false);
>  		print_hex_dump_debug("New vmbus offer: ", DUMP_PREFIX_OFFSET,
>  				     16, 4, offer, offer_sz, false);
> +
> +		vmbus_setup_channel_state(oldchannel, offer);
> +
> +		check_ready_for_resume_event();

This is the error case where the new offer didn't match some aspect of
the old offer.  Is the intent to proceed and use the new offer?   I can see
that check_ready_for_resume_event() has to be called in the error case,
otherwise the resume operation will hang forever, but I'm not sure about
setting up the channel state and then proceeding as if all is good.

> +
>  		return;
>  	}
>=20
