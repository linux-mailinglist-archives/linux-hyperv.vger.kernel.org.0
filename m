Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 955902DE64A
	for <lists+linux-hyperv@lfdr.de>; Fri, 18 Dec 2020 16:15:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727333AbgLRPPX (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 18 Dec 2020 10:15:23 -0500
Received: from mail-eopbgr770109.outbound.protection.outlook.com ([40.107.77.109]:4366
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727292AbgLRPPX (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 18 Dec 2020 10:15:23 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JuS/oqHhayVwNIKFD5xIOTgFHo9FLCeCyfviE5fgaLUXPrfILk1+BKzei0tnthN8WF27+0PMw4r9EnBfhLM/L2k/TGkzK25G91hur6KNBVAnidMiHCeIeG3X/w88w4NUTx6vyRjAeb+BrJbznkJ7gDuhKBoibUnyCGISej8+2QcFtrOtB+9hfdApZ4jD6e739pPXfpYHKa5AMSubaGEyVidvI/GMqfEOhBAUwAWeDyQogo5bDyY7RCXVFf7JZhLxGLG9RnBqjXVXTkK1X+Ph2/pVMQYMIuihF0sqCLqyLge2sTiZMu96iUZj0/vV7L3fQVNjJKXbOS56W8FZ7ahruQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TG1NDWSdDGahNpTIec9s9iadWmeVMyOjCZ+30FVxfZI=;
 b=mFGYns2nbs5hjbrBBkU0yFXbnpWtgDgwMrUZ5QX29LdjFPnEFbKEhEOZ7YW4iFxxHF7hMxJErXffqnsj3VB44pX7MAP6T3MdCvgzYyyS5ToSk30t+TOG5dpGE703zXtza7Ov5FHrYDFCPShRDVU42ZabnamA9XqhfF2LdtJoiBWCdMoulAZlZLOHyrTzik/JOw0mfEPjV4fOfZbHp9V4h4ef05xgyEtPwXvUQEia1IsVDOiQQ+B7mH7Y01yR/UWm7ymHf+9KVvSzYZCPIjij7p7nvV3SyefB5ZstFXsGy+R5etLSnXZU2vBDmP+kDnOtzIibLhw/USWy/8Bfq65bbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TG1NDWSdDGahNpTIec9s9iadWmeVMyOjCZ+30FVxfZI=;
 b=DLARS7MRpQCC1AX2BawsPc0dGMT+dH0cGV3iTfS+ztOwx8eeDcAiDRlX7AYObcPz5WMsvRDQiox9/5D1KXnYEUmD4FNe0s+tSaxrYKP+U+RS7ZP78vtZMgzZC37qUk+Ul3B5holViDB8byDvluCFbIsvfCQRzpZPUWNVei1vw3A=
Received: from (2603:10b6:302:a::16) by
 MW2PR2101MB1049.namprd21.prod.outlook.com (2603:10b6:302:a::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3700.2; Fri, 18 Dec
 2020 15:14:40 +0000
Received: from MW2PR2101MB1052.namprd21.prod.outlook.com
 ([fe80::b8f6:e748:cdf2:1922]) by MW2PR2101MB1052.namprd21.prod.outlook.com
 ([fe80::b8f6:e748:cdf2:1922%8]) with mapi id 15.20.3700.013; Fri, 18 Dec 2020
 15:14:40 +0000
From:   Michael Kelley <mikelley@microsoft.com>
To:     "Andrea Parri (Microsoft)" <parri.andrea@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>
CC:     KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
        Saruhan Karademir <skarade@microsoft.com>,
        Juan Vazquez <juvazq@microsoft.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>
Subject: RE: [PATCH 2/3] scsi: storvsc: Resolve data race in storvsc_probe()
Thread-Topic: [PATCH 2/3] scsi: storvsc: Resolve data race in storvsc_probe()
Thread-Index: AQHW1LPxaxM53vG1lECQS0UzSsNEUan891VA
Date:   Fri, 18 Dec 2020 15:14:40 +0000
Message-ID: <MW2PR2101MB105224177C24337EA5C05303D7C39@MW2PR2101MB1052.namprd21.prod.outlook.com>
References: <20201217203321.4539-1-parri.andrea@gmail.com>
 <20201217203321.4539-3-parri.andrea@gmail.com>
In-Reply-To: <20201217203321.4539-3-parri.andrea@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2020-12-18T15:14:38Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=37c99b07-190b-4282-aa46-2a3127a9822e;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=microsoft.com;
x-originating-ip: [24.22.167.197]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 6bdf4190-bf3b-4d6f-5274-08d8a367a452
x-ms-traffictypediagnostic: MW2PR2101MB1049:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MW2PR2101MB1049A6230D891C9BB09ABE09D7C39@MW2PR2101MB1049.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1751;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ij77fsTI3MAHXOCc2HRJAhwc1rBsGih9yhamvsFHL8rBquU84QgcKuvMObyqKuPM7tKH+tFJf7Oz7lNqwc/M5nkza8t8zwsYt1Li2v5OoyHUNxFxWQqmjtSBDtydgEbP0l9yGoD75UqK02+u+xhubIZEKSOH9wBiADN537wn1OEiqZcGNehmcK3QNeB3KWPgqmvtX3ee5yglFNA9+FQ1kP7l1XYaqrCOxxUEST2cP9J5GbsFaVnSTtAMGSnuJq/gms0+JaxJHFbpSEoltsfXuSp/mNe6LDEK3abrWO6Af0G3SDoLFdbKOtEumajyBifqycPULF9xSmswoRFR8Pf5BpHckLdLLtbt4VQODE7WxBpeG4MQESJyPJ2FKJjzxcBtG3g76Kn8mW1fw1RvluMdEQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR2101MB1052.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(346002)(39860400002)(366004)(396003)(136003)(478600001)(71200400001)(2906002)(4326008)(82960400001)(76116006)(33656002)(54906003)(110136005)(7696005)(10290500003)(9686003)(66556008)(316002)(55016002)(6506007)(8990500004)(26005)(4744005)(64756008)(83380400001)(66946007)(8936002)(186003)(86362001)(66476007)(52536014)(82950400001)(8676002)(66446008)(5660300002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?nAV8eg2qVKi9nDCvNN7xezP/WP+FE9wQCxwhrh5NeYbaI/jQPcv+Ati8x9Ga?=
 =?us-ascii?Q?74WjsgFpFBT3UG1/cVBlTmSdy/snd2MWnQyn9uVZtL5bs+NH1bPScGwGrXJy?=
 =?us-ascii?Q?08AnJ35rNodiIEY6nTdyFjxDKpXPDOzZSWmqG6ZXp5HAhuV3TU/jq94XnsvH?=
 =?us-ascii?Q?RoKfCbezYzR4fPmExBzEx2UjZtmE+Ndsy7Fwao9nbpvTDThx8YwNqm9yITj+?=
 =?us-ascii?Q?A4fgw12KPg9vcOj2aOM9KJXzQZC9fdV6ObhUu85MtvBjwVYyFhh33kMLooEU?=
 =?us-ascii?Q?mlytPdJ1Fg94UCjU/KvEidr17go+ZFJ1ino2B3LO1WjbgleBDToRk1zt1JTz?=
 =?us-ascii?Q?ZBreFtOlK6WqQRr+hg0vjEocPWUAO+N238aNr4ZQibmd71yjo+DTQbwFOh+M?=
 =?us-ascii?Q?o9lX3NV6cdthtWYTF/1pcv57Aj48koOUi2dQLkFBg71Lh4wAV/45Y7MGkQ7K?=
 =?us-ascii?Q?MbArHCCpRuEB6oSxknqyDpNJ9erfceNJYahfSryjpQUluIa5/SYzHz+G2r12?=
 =?us-ascii?Q?RtHcYeckWX3KWc5A9OatGNZvjCFPVQtyqWbpR02YzDNk3qVyL58ew+Dd0ix+?=
 =?us-ascii?Q?9eInYjRY3mzuGGI90OwlKY3OS+20fEjmtjRs1UDiHdGuU8yR1kvcB6T/SZPu?=
 =?us-ascii?Q?iNe8NEzudqqnmu4SxgblO1cu9idh3PO/Uf8RlGBOsV84YEd81ulEtAWul4IK?=
 =?us-ascii?Q?Uo7oS3MIQl873ayomVTLOfytaZEWPjWXH2gdCnDtAcWXvXpJVaJfpd46869f?=
 =?us-ascii?Q?UqVAf7mJXuy+vkW2w1yp35mmH8/0u+HBKV+/N3Fnu7j+2nKVdrAHe5e36aA+?=
 =?us-ascii?Q?v77E9FhildxRBbxCHcRcj/vxrwXmN1tpOqRFhc0xj9il71Wclqzygodd1A3C?=
 =?us-ascii?Q?o+wcSL77BJApWwznqo4r+hrleioeXlZ7A+MyktFRvxuxHn45LeHQolDawTfw?=
 =?us-ascii?Q?F6TtaenHzb6CryEkPt4YO8swAmqr5LXJDcDZSAGFqzM=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR2101MB1052.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6bdf4190-bf3b-4d6f-5274-08d8a367a452
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Dec 2020 15:14:40.5333
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wkg2n7eU5lB280nHGQKGHIFf1YsbfUeomnzEiQm5G05kVb8o4mbao/AdolAjeorTs/UZypcORwNemDaJXBAXcrklbL/1yw6xiK5WyqSuzWk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR2101MB1049
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

From: Andrea Parri (Microsoft) <parri.andrea@gmail.com> Sent: Thursday, Dec=
ember 17, 2020 12:33 PM
>=20
> vmscsi_size_delta can be written concurrently by multiple instances of
> storvsc_probe(), corresponding to multiple synthetic IDE/SCSI devices;
> cf. storvsc_drv's probe_type =3D=3D PROBE_PREFER_ASYNCHRONOUS.  Change th=
e
> global variable vmscsi_size_delta to per-synthetic-IDE/SCSI-device.
>=20
> Suggested-by: Dexuan Cui <decui@microsoft.com>
> Signed-off-by: Andrea Parri (Microsoft) <parri.andrea@gmail.com>
> Cc: "James E.J. Bottomley" <jejb@linux.ibm.com>
> Cc: "Martin K. Petersen" <martin.petersen@oracle.com>
> Cc: linux-scsi@vger.kernel.org
> ---
>  drivers/scsi/storvsc_drv.c | 45 +++++++++++++++++++++-----------------
>  1 file changed, 25 insertions(+), 20 deletions(-)
>=20

Reviewed-by: Michael Kelley <mikelley@microsoft.com>

