Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A6A0215BC4
	for <lists+linux-hyperv@lfdr.de>; Mon,  6 Jul 2020 18:28:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729358AbgGFQ2R (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 6 Jul 2020 12:28:17 -0400
Received: from mail-dm6nam11on2097.outbound.protection.outlook.com ([40.107.223.97]:25091
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729293AbgGFQ2Q (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 6 Jul 2020 12:28:16 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XEc5CEEvWM1ZLsGJWywseh+qF99ZL1+/M8BBA0yhQFVCZLBzS3DzsCKAPxkH1qzASQcQlcO4ve8QiEmLcC5g4h58PMlNaY/zGKGtrq7gIgdAz2HaSVD2oBdc5pXSA1IzWz7LwUClEmHH3v40MELeXM+U23BtW9TkiuCf3vXOFfLDlmIvG4Qzmj3rPbtUHCpegmzqXo04Yq0M2zpCJzk0i5SV99QAKcNfLRxe51gdJ3IdyFV801OMlmAjNAniRQQmVVN7NhWRiQo6rI6OigIDEj5xbMjUb7ij5m6PnO010lGA/tFRjtCn1B3A1NtKggll1OB4Ldvwr/QUgfZqn3cS3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C9kqaP34drul+tHSdUh5sCmkdNNn3Wtu3z4pEWWFKHU=;
 b=HkoQQva/T9ZCbEc5JYa7teEjtEgueeDi7cu/904aqbw+t8pxhmZT2nN6pduxDbDpOaru6S/7ws5TmixUV63aEjUZjDKzw+fplyvtR1siH2fIkGsCda/w4mDfSSLUxAJcciv3/ACeYDJSd6x2LWFJn63rG/td7kzw9io/pgVx42/ds6tof/vw/JvWv1+ZFn2AXBE1bxwxBYgnFC0IQYywvh887RFgsdKEtI9njFiDwShF0pFf26ooIrYU5haG7jt6WaQuLfsBXL+r9l2LzbaDJJYfA1wfjP93r9ZiBudA6bGdjq9k64EfJZTeErP/kLUb6jPMFPZJvL4wnyRX42+uEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C9kqaP34drul+tHSdUh5sCmkdNNn3Wtu3z4pEWWFKHU=;
 b=NsyxaqVWhOA0erI/4J/WUm2zDPEUdN+taK5AaB/SUij4SiiGbYYWDlesqni4Ky0APdVGGdHvLYqanztXhHtaQc9gnBUe/fPvQZQMlK50OWc9xi1ENJ+69v7QBnqG9/gpRiCjfrH/0Ae0I+3yYj2J5iU2B/yBTKACtf4CR+a03/U=
Received: from MW2PR2101MB1052.namprd21.prod.outlook.com (2603:10b6:302:a::16)
 by MW2PR2101MB1804.namprd21.prod.outlook.com (2603:10b6:302:6::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3195.4; Mon, 6 Jul
 2020 16:28:14 +0000
Received: from MW2PR2101MB1052.namprd21.prod.outlook.com
 ([fe80::fc14:3ca6:8a8:7407]) by MW2PR2101MB1052.namprd21.prod.outlook.com
 ([fe80::fc14:3ca6:8a8:7407%8]) with mapi id 15.20.3174.001; Mon, 6 Jul 2020
 16:28:14 +0000
From:   Michael Kelley <mikelley@microsoft.com>
To:     Andres Beltran <t-mabelt@microsoft.com>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "wei.liu@kernel.org" <wei.liu@kernel.org>
CC:     "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "parri.andrea@gmail.com" <parri.andrea@gmail.com>
Subject: RE: [PATCH v4 1/3] Drivers: hv: vmbus: Add vmbus_requestor data
 structure for VMBus hardening
Thread-Topic: [PATCH v4 1/3] Drivers: hv: vmbus: Add vmbus_requestor data
 structure for VMBus hardening
Thread-Index: AQHWTzxTbKgvOtdBrUyvbpBu93/Jcqj6xi6w
Date:   Mon, 6 Jul 2020 16:28:13 +0000
Message-ID: <MW2PR2101MB105242B7566BDBB86D58D825D7690@MW2PR2101MB1052.namprd21.prod.outlook.com>
References: <20200701001221.2540-1-lkmlabelt@gmail.com>
 <20200701001221.2540-2-lkmlabelt@gmail.com>
In-Reply-To: <20200701001221.2540-2-lkmlabelt@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2020-07-06T16:28:12Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=91ff5ab1-675d-4a61-bce5-d2951a08a675;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0
authentication-results: microsoft.com; dkim=none (message not signed)
 header.d=none;microsoft.com; dmarc=none action=none
 header.from=microsoft.com;
x-originating-ip: [24.22.167.197]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 222776d5-5d4e-449f-623f-08d821c994b8
x-ms-traffictypediagnostic: MW2PR2101MB1804:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MW2PR2101MB180431C069B0EFF1635DD9A6D7690@MW2PR2101MB1804.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3383;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 7RZGei7BRucB5UzOWlafTNkyOxxBa8fNGyMRUCR2vN+rhFsRLumiEcdsqiobEe89S/WfnocgwGeWJdsdxa+PjP29oeYdrEg+2EFY5Lk7h0bIapT7KRZhLqV0sMuzzMOn9zK88blPj2sF2ZMfRP1hwl4U7FaWTlwUbUvD+oUO53qsYFcrHn3HFzzePeIGuwFyAtyRPZTvyJi3Qo3IOQNVw/F2q5JJpzFCeV+IUWG9wUYjIUYcuRMUy0kSvJRKD91WTaBYVdCuKP2fLsKHLATjvMb1yXE2XZtdIMqmczujcPoOQ88kN8stjXjbcyMZwNE0
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR2101MB1052.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(396003)(39860400002)(136003)(366004)(346002)(376002)(33656002)(26005)(6506007)(82950400001)(52536014)(110136005)(316002)(82960400001)(54906003)(478600001)(2906002)(4326008)(10290500003)(9686003)(55016002)(186003)(71200400001)(66476007)(66946007)(64756008)(76116006)(66446008)(66556008)(5660300002)(7696005)(8990500004)(86362001)(8676002)(83380400001)(8936002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: H/GWpOx5PqA2/8+sy9jPpnNZS5z6BdTLn0fWLFGsNsWlcQFhbe6uREEx736f2+R8MXrw43UAkrtLliEJY9PYd6BXcSefSN2MtRJaQ2VMPI8yu99wIoT3eBOMTMB86Ro+Drf68xVfpJY2RtWpN70d2mbmahmrAA74tTYCVHXwqZUly0MLioHwoXj2srqcaqzE7BHKeh5fLaQj3xRaZZ6pU9DY4uT0e43odNi9Un7UIcLUdTHMYFP2IN4jlL3u4ks+pmidYcV5AVKgUP+Ahlmu8zD3JFM4NOcsGecysWlcsJKROyJ3RiB2HJE4zW+U5PJp8D5KbYRbV7vEL/QsR6N6EXFD7kNAaTAqT69se+qq4eB4GXhd72KwO6J5prgKDPbD2N6s0xXL76qPx8jZuuN5R/pA0BumsAO7dUm3GbBSEbx/uxnRfVPeihkGzRXFVHvaYeVmVPAF31Wndr9vR5emq5Z9KKdtBqUkegmNnGSL8FAfnJD84sSl2aDLqd0n/Zuk
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR2101MB1052.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 222776d5-5d4e-449f-623f-08d821c994b8
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jul 2020 16:28:13.8940
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nz8fR4ImI2et3HcdZvMuftUc3k7e3uANjw1EfQjlOQUt0N1qG58W/bJee+zg/kPwbPiiVj9OR4J0SaAiFV6COHsxaLuHthnuLY7c6RI6sqM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR2101MB1804
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

From: Andres Beltran <lkmlabelt@gmail.com> Sent: Tuesday, June 30, 2020 5:1=
2 PM
>=20
> Currently, VMbus drivers use pointers into guest memory as request IDs
> for interactions with Hyper-V. To be more robust in the face of errors
> or malicious behavior from a compromised Hyper-V, avoid exposing
> guest memory addresses to Hyper-V. Also avoid Hyper-V giving back a
> bad request ID that is then treated as the address of a guest data
> structure with no validation. Instead, encapsulate these memory
> addresses and provide small integers as request IDs.
>=20
> Signed-off-by: Andres Beltran <lkmlabelt@gmail.com>
> ---
> Changes in v4:
> 	- Use channel->rqstor_size to check if rqstor has been
> 	  initialized.
> Changes in v3:
>         - Check that requestor has been initialized in
>           vmbus_next_request_id() and vmbus_request_addr().
> Changes in v2:
>         - Get rid of "rqstor" variable in __vmbus_open().
>=20
>  drivers/hv/channel.c   | 158 +++++++++++++++++++++++++++++++++++++++++
>  include/linux/hyperv.h |  21 ++++++
>  2 files changed, 179 insertions(+)

Reviewed-by: Michael Kelley <mikelley@microsoft.com>
