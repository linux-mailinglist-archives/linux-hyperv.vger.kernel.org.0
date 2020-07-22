Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8530B229FE0
	for <lists+linux-hyperv@lfdr.de>; Wed, 22 Jul 2020 21:10:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732425AbgGVTKO (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 22 Jul 2020 15:10:14 -0400
Received: from mail-mw2nam12on2132.outbound.protection.outlook.com ([40.107.244.132]:61257
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1732415AbgGVTKN (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 22 Jul 2020 15:10:13 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=arKHaFMdY/TdhcmVQ0sbDa4R4OKWlh/Ub2+ZFh5YOjlPzdKAe8XOM8skTuqTEulGdbRfEWZEkfRvnMvEF10yQcMsApHGs7iWBqu4DGR90PzGSmhQTqzPAYSleIg0+YwxCZGGWqprJF31ed+vQTgDkXZO+d4MLmlERka/1F80QSUxEUJZvAlTVZm1XrYFeyA/1JwfuczMtQNO8YUgq3jYYGiC27tRPmjv3OyIZ+o72Hcjha+fdSQOQA3rNIylT8y7ZP7f03srlac5/o7zgbO0VFok12cDKp/WX9KSHoTQiRxK+cG0YFMBoKTzbN7baIcnUNVucp9+B4Y4/eaavJgg9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YJx+z/ZEPEJAhBBhDZph62Yz+9PoCUQWhf12zN7fPms=;
 b=FyoQEeV+shNhVE83m+FlCY2EaxpIyUVTPn1YRYENbFcoBNCRv01DJ5QnNmZ+LU3V3UQWMxFS9BFyQNd4GOWY3XRNON48cVrOk6sAF2Rz4aeHna5zvt8JBjUjCPkR8eLiKtx+Op633CLH+h3a51o1vwHncoNKWm5H0teU7w/B246BadeGORgj2fgY3H/SwOGwCPsGQfn64z83LK5el3n5dYRSwR5yiYqvuzz9026qESl5HJkcq7gMJvQywKRf9dRFqkWPrHNhPnqqm+MXzlTYK8WhOHtqhUjVa5SvKhtDt2+N7MMccI2kB+qdtv7vQHkOvFCjo0bQCc3HossdnZqbSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YJx+z/ZEPEJAhBBhDZph62Yz+9PoCUQWhf12zN7fPms=;
 b=I7FwnBUSJLkPtmPuS23Pdr7YmUr9rNIocYjujhEJdI6Y1BUfH0Y2kd2mblq+0Nzk4fhV4ZPAtxl7TllhdqNSOsZ33AxFYs7dzkK48IfdbUJ6tW8zWHMEsEGZXmF1+ZmMPG6FWbkrRyMIfaVZFxlNZxs1np2xiylo7DPFzmQK/wg=
Received: from MW2PR2101MB1052.namprd21.prod.outlook.com (2603:10b6:302:a::16)
 by MW2PR2101MB0892.namprd21.prod.outlook.com (2603:10b6:302:10::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3239.1; Wed, 22 Jul
 2020 19:10:12 +0000
Received: from MW2PR2101MB1052.namprd21.prod.outlook.com
 ([fe80::fc14:3ca6:8a8:7407]) by MW2PR2101MB1052.namprd21.prod.outlook.com
 ([fe80::fc14:3ca6:8a8:7407%8]) with mapi id 15.20.3239.005; Wed, 22 Jul 2020
 19:10:12 +0000
From:   Michael Kelley <mikelley@microsoft.com>
To:     Stephen Hemminger <stephen@networkplumber.org>,
        Andres Beltran <lkmlabelt@gmail.com>
CC:     Andres Beltran <t-mabelt@microsoft.com>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "wei.liu@kernel.org" <wei.liu@kernel.org>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "parri.andrea@gmail.com" <parri.andrea@gmail.com>,
        "James E . J . Bottomley" <jejb@linux.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        "David S . Miller" <davem@davemloft.net>
Subject: RE: [PATCH v5 0/3] Drivers: hv: vmbus: vmbus_requestor data structure
 for VMBus hardening
Thread-Topic: [PATCH v5 0/3] Drivers: hv: vmbus: vmbus_requestor data
 structure for VMBus hardening
Thread-Index: AQHWYFNyr+n9YUjzC02M66ZYOGFeFqkT7oQAgAAHzvA=
Date:   Wed, 22 Jul 2020 19:10:11 +0000
Message-ID: <MW2PR2101MB105203431E44B955A82AC672D7790@MW2PR2101MB1052.namprd21.prod.outlook.com>
References: <20200722181051.2688-1-lkmlabelt@gmail.com>
 <20200722114034.443f5af2@hermes.lan>
In-Reply-To: <20200722114034.443f5af2@hermes.lan>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2020-07-22T19:10:10Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=3562a0c3-2fdb-4a6e-9679-6c2a9bd801ba;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0
authentication-results: networkplumber.org; dkim=none (message not signed)
 header.d=none;networkplumber.org; dmarc=none action=none
 header.from=microsoft.com;
x-originating-ip: [24.22.167.197]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 08273f7a-501b-47b0-0fbc-08d82e72dbb6
x-ms-traffictypediagnostic: MW2PR2101MB0892:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MW2PR2101MB0892C9F52DC6AB908A80A5F1D7790@MW2PR2101MB0892.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: UBgFU6YxPj+ZwUdvdBqy0bUj2U9J6G4dx9rNfxlIeQ9qCrw7ZC8oYw/iieRSIF6nzgmmpzbYcQzEjrSYAF4QGETSSyiRiHFfjUBXYq4GzzjvcUEcxK2tX7zfVuQOsAKRlCyp2NJcC9i2WmI/pXG/TSk7EEYYXIVc1ax+ZzhGvy1EOv71UnetHRizLoDjMD1dn2MZozUxJadZ2rcJWFgXlw5kr1OFhjrvDWOZNDqEFar6N2PlR/nT/oOuHapgFQ8Q8WDge4IlEO7pESbsrTKWwRHpfgPldpvm/EUUgUK4sr3CzKx9kPOmx+9BY9zwL6X5xzSBJaZRGuYyjgNNhEc3Ag==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR2101MB1052.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(39860400002)(136003)(346002)(396003)(376002)(366004)(8676002)(5660300002)(83380400001)(7696005)(6506007)(10290500003)(9686003)(2906002)(186003)(54906003)(86362001)(55016002)(478600001)(26005)(110136005)(66446008)(64756008)(66556008)(66476007)(33656002)(316002)(66946007)(8936002)(76116006)(4326008)(82950400001)(82960400001)(52536014)(8990500004)(71200400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: HVBYdhaoPUfSanYBUKb0Idh1aWWOuaDcLiU22pVQwUCXJjGQJ+uII8oJWbAXgVWUANDXsmAhlmKuKGJuay9u9/I3PyVeq4nityoTGUl5grUt/HiidqTxW/Rz9h3qUL/M9WoR/EOeDFUIPBKDLITpnlJ1rPwOoo4SofNbyVn6WF3rSyFgZiV8uxT3jD8LKah9xvwdLHFPMKW6Dce0x8ZA9JLrSNj9D3aC85gfCa3o/BXyeo4/kN231BZbcs2lO+o/N7F/2gVKM5I6UhSDRXvObZ6++XWvHCfVYoUkl5IASBVorJLPro0j0l18sHS7L75E7hCtIY7/yFQyxGquGTEcOUwZ17ac1tp6baAg4nADBAqdPqK9Y1cz/g/A+JsNiK19foZBsdc36xl5+ISl7b8lmMHysLW7t587G/SmKGYwsg7w4m3HyaLnAlK0Cp6jkRuEv6tQh7Be/7ca8FsWy3l01q72JGZpt9EJDEZGXhJdnHPT4P1wyUth5ogCdMrO0GASWycXR9bXHFFRwXM/UucI4LafQyL3+FduqG9O2ronqJeqHINlc6LfnHInDSGycvZu/q6/TMuqzeZ3i4yCedgof5WQyG4AKE7WGLcxP9Fr26v8ZA/j39wQAEPvWURix3V3R+0O2lIh1mASDNcpIecpQw==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR2101MB1052.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 08273f7a-501b-47b0-0fbc-08d82e72dbb6
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jul 2020 19:10:11.9556
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yWGf88LmqXxzt6bN5vZpVSNVN9h5fu3eXTuSJ30SB48EYGv3AH+nBC91Qd+8fsJjbK/x3IuVIO5WaLvdSfyfo3WdL0cYwVNXwnOOAoi510Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR2101MB0892
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

From: Stephen Hemminger <stephen@networkplumber.org> Sent: Wednesday, July =
22, 2020 11:41 AM
>=20
> On Wed, 22 Jul 2020 11:10:48 -0700
> "Andres Beltran" <lkmlabelt@gmail.com> wrote:
>=20
> > Currently, VMbus drivers use pointers into guest memory as request IDs
> > for interactions with Hyper-V. To be more robust in the face of errors
> > or malicious behavior from a compromised Hyper-V, avoid exposing
> > guest memory addresses to Hyper-V. Also avoid Hyper-V giving back a
> > bad request ID that is then treated as the address of a guest data
> > structure with no validation. Instead, encapsulate these memory
> > addresses and provide small integers as request IDs.
> >
> > The first patch creates the definitions for the data structure, provide=
s
> > helper methods to generate new IDs and retrieve data, and
> > allocates/frees the memory needed for vmbus_requestor.
> >
> > The second and third patches make use of vmbus_requestor to send reques=
t
> > IDs to Hyper-V in storvsc and netvsc respectively.
> >
> > Thanks.
> > Andres Beltran
> >
> > Cc: James E.J. Bottomley <jejb@linux.ibm.com>
> > Cc: Martin K. Petersen <martin.petersen@oracle.com>
> > Cc: David S. Miller <davem@davemloft.net>
> >
> > Andres Beltran (3):
> >   Drivers: hv: vmbus: Add vmbus_requestor data structure for VMBus
> >     hardening
> >   scsi: storvsc: Use vmbus_requestor to generate transaction IDs for
> >     VMBus hardening
> >   hv_netvsc: Use vmbus_requestor to generate transaction IDs for VMBus
> >     hardening
> >
> >  drivers/hv/channel.c              | 175 ++++++++++++++++++++++++++++++
> >  drivers/net/hyperv/hyperv_net.h   |  13 +++
> >  drivers/net/hyperv/netvsc.c       |  79 +++++++++++---
> >  drivers/net/hyperv/rndis_filter.c |   1 +
> >  drivers/scsi/storvsc_drv.c        |  85 +++++++++++++--
> >  include/linux/hyperv.h            |  22 ++++
> >  6 files changed, 350 insertions(+), 25 deletions(-)
> >
>=20
>=20
> What is the performance impact of this?
> It means keeping a global (bookkeeping) structure which should have
> noticeable impact on mult-queue performance.

The bookkeeping structure is per-VMbus channel.  There's nothing
global.   Andrea Parri previously did some testing and reported no
measurable impact.

Michael


