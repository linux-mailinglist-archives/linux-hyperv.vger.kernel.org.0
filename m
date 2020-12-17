Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6FB102DDAE4
	for <lists+linux-hyperv@lfdr.de>; Thu, 17 Dec 2020 22:33:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728654AbgLQVct (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 17 Dec 2020 16:32:49 -0500
Received: from mail-dm6nam08on2099.outbound.protection.outlook.com ([40.107.102.99]:48940
        "EHLO NAM04-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726689AbgLQVct (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 17 Dec 2020 16:32:49 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BRfU2iGpC+/KlkxM+8nHgqi90cnAVmjCCjZ3qQd87AXP/62+X88dhyQoO8FvUFePDfOF7w3bXU0RIvUZ8HUekxE8UmKeV5nph1IGV5xdB5fxvP3jX0F4bm3nq3I52OxIGUOh/CxgbBlQ/+N+b6iP45TSwl9jgv1MqpSpWQjCyrkmIF8pDfGHUleVaX6sw724x//2RDj7rk+GzUZEPhFuUu09/Rq1s+KlB9p/iNtoUsGf3MVuQKp7b9SX1bcAwn7PsoxA/Q6EMa5O8RSfeAeCriJlRKf3zTgqZ1L56gIwihAuBAwnIXDG4SeJwX/yZ7QwBlb2zPexf7+07MzF3QAv1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CRihKhgYarZsDX+Yq2ixCPacGG69g5VnXKm6ry7TjOo=;
 b=jz9B/23p4ONndOSYb01eAMl4nq0b7gZn+kHVUFeWTKZRdQdlWuoItBxSmP3WRJYR2iZEmUYSpukFAzw10CymzXZJfqiLU1wn8EhphsqZbUlDXZQcD4qp2IuRe7SvrT6o7e9s5y4MoxIeQViv9ryKlqSjKrZcNJIzKE/FLznhScjRM3jXExU7sVzxBwNdcTCq5AlCQwEIYOSmcR5EHsbJodrSfnKH8f3WsKvCF42GXLeVurINHDzBOMCvAXfFxqSRwokPXY8My8XWMt322QEvJIRgcs/neY0TpY8GOoJOGXp/cFnl6Iu3hkeodHENpaMtdZZtjIqS2aFmgNrJbXARPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CRihKhgYarZsDX+Yq2ixCPacGG69g5VnXKm6ry7TjOo=;
 b=FZmgEZedIV2xa+7cKfnbQCnDibL1+lgWm40brNwF/+C4rI46rNTQGAz/4TuNJz/WC+ETnNXg2R/qJtXK+Tj5vFxvclaonXC9WhqiHbJCqLbZwjZpQKAX5QORnS6Hy2T+qzXOz7w24Y0JgcdqYUvr+Cm3K3gGXSzoyuItZo3tWg4=
Received: from (2603:10b6:303:74::12) by
 MW2PR2101MB1052.namprd21.prod.outlook.com (2603:10b6:302:a::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3700.3; Thu, 17 Dec
 2020 21:31:27 +0000
Received: from MW4PR21MB1857.namprd21.prod.outlook.com
 ([fe80::f133:55b5:4633:c485]) by MW4PR21MB1857.namprd21.prod.outlook.com
 ([fe80::f133:55b5:4633:c485%5]) with mapi id 15.20.3700.014; Thu, 17 Dec 2020
 21:31:27 +0000
From:   Dexuan Cui <decui@microsoft.com>
To:     "Andrea Parri (Microsoft)" <parri.andrea@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>
CC:     KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>,
        Michael Kelley <mikelley@microsoft.com>,
        Saruhan Karademir <skarade@microsoft.com>,
        Juan Vazquez <juvazq@microsoft.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>
Subject: RE: [PATCH 2/3] scsi: storvsc: Resolve data race in storvsc_probe()
Thread-Topic: [PATCH 2/3] scsi: storvsc: Resolve data race in storvsc_probe()
Thread-Index: AQHW1LPx8TcLl9ziOkOpweRDhUborqn7zdKg
Date:   Thu, 17 Dec 2020 21:31:27 +0000
Message-ID: <MW4PR21MB1857924EE47FDAC8071BD69EBFC49@MW4PR21MB1857.namprd21.prod.outlook.com>
References: <20201217203321.4539-1-parri.andrea@gmail.com>
 <20201217203321.4539-3-parri.andrea@gmail.com>
In-Reply-To: <20201217203321.4539-3-parri.andrea@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=88381b8b-4801-405b-bcad-55a0f9bf0d85;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2020-12-17T21:28:51Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=microsoft.com;
x-originating-ip: [2601:600:a280:7f70:240f:4d5f:961f:391f]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: a487e1a1-5f92-4afc-d6c6-08d8a2d31c8a
x-ms-traffictypediagnostic: MW2PR2101MB1052:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MW2PR2101MB1052045B5BE085D3C8E21425BFC49@MW2PR2101MB1052.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1751;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: BzyVQDnr8dao7ECq5Yq4B/61QhMw4wkx5pfqWytv9dk//vJON73nkbc6REMAifak7eeqG10v7ElpcAn81JqdTKMdOGQjvZfxW1fzHXHwUQKy40gsB4Shc6t3yNvBSDEd039ap0RzE9nLSpF5/3rTA/EKLungQ/Q7a29q39DH+KHXCuk28gJYvOFp1IqoPpaAeepGmH/OnbIqQGKpwwi56SSL5f42TpjvyWBuHMs6/2rFXFV1D/1M3QrX9DKehFhS3X3fvr0jopCKBCAR3/ihQ6eWpmNvemCdIZe5OBmeYXW/HkoFJknwayQFuqqYc5p0ZhknGm6KszZVjbj/FFpCfejwMu1YvSrXyhkEENWD35UwNb6If9rpu+xIfZgRNhvRXCHLG8N75AJnWvoAzOMmew==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR21MB1857.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(346002)(39860400002)(396003)(136003)(366004)(8676002)(478600001)(55016002)(66476007)(66556008)(10290500003)(52536014)(66946007)(9686003)(33656002)(54906003)(5660300002)(66446008)(2906002)(7696005)(6506007)(110136005)(8936002)(4326008)(4744005)(316002)(82950400001)(82960400001)(71200400001)(76116006)(86362001)(186003)(8990500004)(64756008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?CT2xjf6eRI7FmTj8y3RnojNwWN3tItlU7X6YDXD0OPapwfKRmbG1zzhIBSgh?=
 =?us-ascii?Q?jgishaUS1m2nEe2aP3hgTMNLPXsZnizxJqcbP82/812+8O2C60iDz0vY0bPj?=
 =?us-ascii?Q?99dagUaoe79pe3YaK1RiPpxie1Gji+gWZAPLnDF43eVVTaFW9h3MVvjSBOLR?=
 =?us-ascii?Q?7ffXnh1BgXBsnnCr9gABuRHdSoWur4NZXOW/Aj6FNAEYjvYdAAT20MJ6wZFP?=
 =?us-ascii?Q?h+E49E/bIyajD5IvOSpRgorDdeu8/p39z4S55ZQj+xVo7sKW+sa7I5pdaw34?=
 =?us-ascii?Q?/oYy9HtNbVrnuIT8XISxMGw0KEgqiLoCwNOVsAuXMKaw1mzJs6sjog1lcvcA?=
 =?us-ascii?Q?DYO2BNMPuo9ea97ngxfVjwS26+A2bp/eXJQHAOljBhtYof3DNDugi+PJjbNj?=
 =?us-ascii?Q?X75XAFp6KBcdLeXkfp6kxy8Rvb/C45t8NFfTYhX27TvqhdowpJ1HmD5hPEv5?=
 =?us-ascii?Q?bF8i54tLuJrsRvKPEG8EGGdd7wnORQiWAV3/qeSU6iGpoy6Nrwg/ZY7o5cVS?=
 =?us-ascii?Q?gCoKCznnBQ6vQQCdY1HdqyBUNuC+IbSTM0xwmePlfh65Bv1QZ98KsWDlHk/q?=
 =?us-ascii?Q?tJLJM2dazFRDO08N07FlI/f2nApSXjmA4JtqIG4FCQojR+ByvGzxXrLx8bqe?=
 =?us-ascii?Q?qvd/2ZprGUp4xaXgmRIyED0+wzQbP3u45y91F3V9fZFB97jDzyFyW7GPxekb?=
 =?us-ascii?Q?olVtRh4WEJmANLnf6DzSCi6VDN2cwrh9on069WzBmuD2HmtasKD+Eky/fZ+e?=
 =?us-ascii?Q?tDxO3LIPSVG/ThYH4IRGaimZ4Ez2E68kJXFDRHbYmTHGKCO2/w+3x5CMKbPI?=
 =?us-ascii?Q?aTSZdV4S+enfvrdPZt++Pko0weBR9ybla9xQWi9QYsC+fmOd3ExzGULVUwtV?=
 =?us-ascii?Q?ZN+tGkManxSxlMl2uNuAWhOznza2/DgNvbt6YReS8hkr1dJ9oUAx9Oaof3iU?=
 =?us-ascii?Q?tP74HudTwiB7VuK/GFDzAJfsuqKwX8yXjV4WbkZZZvjiWkDuuAXRl+G96aio?=
 =?us-ascii?Q?2bQ0JWp+XS9WLfxm9lnz6YA6FCK+BuD94qCOR6W4D/D4gOw=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW4PR21MB1857.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a487e1a1-5f92-4afc-d6c6-08d8a2d31c8a
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Dec 2020 21:31:27.2968
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZEM4LZgH5VJGl8cxGlyStxpsYBbJD+8hoOnE/VU8wn4tq3TPEooecaoXzlEjOlfXBD6SqKbDFe34IPaZVnj58A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR2101MB1052
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

> From: Andrea Parri (Microsoft) <parri.andrea@gmail.com>
> Sent: Thursday, December 17, 2020 12:33 PM
>=20
> vmscsi_size_delta can be written concurrently by multiple instances of
> storvsc_probe(), corresponding to multiple synthetic IDE/SCSI devices;
> cf. storvsc_drv's probe_type =3D=3D PROBE_PREFER_ASYNCHRONOUS.  Change
> the
> global variable vmscsi_size_delta to per-synthetic-IDE/SCSI-device.
>=20
> Suggested-by: Dexuan Cui <decui@microsoft.com>
> Signed-off-by: Andrea Parri (Microsoft) <parri.andrea@gmail.com>
> Cc: "James E.J. Bottomley" <jejb@linux.ibm.com>
> Cc: "Martin K. Petersen" <martin.petersen@oracle.com>
> Cc: linux-scsi@vger.kernel.org

Reviewed-by: Dexuan Cui <decui@microsoft.com>
