Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 28CBF3C9300
	for <lists+linux-hyperv@lfdr.de>; Wed, 14 Jul 2021 23:23:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235565AbhGNV0A (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 14 Jul 2021 17:26:00 -0400
Received: from mail-sn1anam02on2098.outbound.protection.outlook.com ([40.107.96.98]:40612
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S235535AbhGNV0A (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 14 Jul 2021 17:26:00 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oGYvbljCy23SEuNFyghZ3PtBaPGL63wphxasg6sN4IHDLZ45mZafJo/L7lSa7ws4Kr1PWGzahmywn1mgkkQ9mefyX4KU/GTQMzAJxZrrRgoVt+xgN5iWvXY1AuKGLDnHjh5o5MIK1Vz521f68Ndw6XbjOViG3NpA99GLaAMUwG1jq6HTNQ7oNs9du937U0USwzrF8+1BZPV9cXz8/MT7oH3ygkZ9lShqy8xgo/BSEprcfYS8cbxxoDh+QAfM/e8qWmTuZxjRTm8jr3NQzW9wSf/bvDEvRNPMFQ0W1vPJdsXk/83Np9oBhd0box99Qh0ZYAzeCAcTImIhzwGyoFvC6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yzJACufIwZafMmW2ALUh5cRvxIAVpKKKH7dTxaiuAc4=;
 b=k7dTxCIKclxo6lL2DVgb7kS1O8X5y30Pvz82ZS9SpgvySjs9/3Hcp+67W6kY+wjbwBG/ZZt+ppGh6W1P991PNSsBHthNtL8Na3tY4WTrtaYQCL3yfrErb0vNED9mEsouXGA+9SuIZ/xJ2SWDr5+zEOX2EjGTn1o5QZT58IjaNXfxEi4yOVgzSHkGQXBw6toAukRUIIvvaj2NQ/nMqSwivpw1ygSQo3IeKDAaIYy4MLJE/6OWyuCIR81ip6s1XKatbY98QGGSlegdcz5gc+02Y9hDgxqHL1MfA6YTsRmOA8K1txu007T9qT4kR8zTwxHWyXNTmSJIP31Uu76fa0tI+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yzJACufIwZafMmW2ALUh5cRvxIAVpKKKH7dTxaiuAc4=;
 b=DeY8lFnntXp/rs+Ig9eNyK2QjoqrP82RBugC5Fr6OtLm1paEasUjpWXGsd4l0RoNvQ5nxnbeyTw9azUotKTiWQD/K7JqMtETWzqpOKbBy3EFZHDkm+leg09qSe4ggfDps426xe5ZyNeMB+UwrWKNdnUJDb/7rWPxTsa4kKMQaok=
Received: from BY5PR21MB1506.namprd21.prod.outlook.com (2603:10b6:a03:23d::12)
 by BYAPR21MB1621.namprd21.prod.outlook.com (2603:10b6:a02:c4::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4352.3; Wed, 14 Jul
 2021 21:23:06 +0000
Received: from BY5PR21MB1506.namprd21.prod.outlook.com
 ([fe80::ec21:a9f8:7e74:5e1b]) by BY5PR21MB1506.namprd21.prod.outlook.com
 ([fe80::ec21:a9f8:7e74:5e1b%8]) with mapi id 15.20.4352.009; Wed, 14 Jul 2021
 21:23:06 +0000
From:   Long Li <longli@microsoft.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "longli@linuxonhyperv.com" <longli@linuxonhyperv.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Hans de Goede <hdegoede@redhat.com>,
        "Williams, Dan J" <dan.j.williams@intel.com>,
        Maximilian Luz <luzmaximilian@gmail.com>,
        Mike Rapoport <rppt@kernel.org>,
        Ben Widawsky <ben.widawsky@intel.com>,
        Jiri Slaby <jirislaby@kernel.org>,
        Andra Paraschiv <andraprs@amazon.com>,
        Siddharth Gupta <sidgup@codeaurora.org>,
        Hannes Reinecke <hare@suse.de>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>
Subject: RE: [Patch v3 2/3] Drivers: hv: add Azure Blob driver
Thread-Topic: [Patch v3 2/3] Drivers: hv: add Azure Blob driver
Thread-Index: AQHXeFpU0avVPr6X1EyU3ZDtwXfEcKtCukgAgABAXQA=
Date:   Wed, 14 Jul 2021 21:23:06 +0000
Message-ID: <BY5PR21MB1506D555BF9F500AF05EDAD8CE139@BY5PR21MB1506.namprd21.prod.outlook.com>
References: <1626230722-1971-1-git-send-email-longli@linuxonhyperv.com>
 <1626230722-1971-3-git-send-email-longli@linuxonhyperv.com>
 <YO8edjd9/2bDz3sO@kroah.com>
In-Reply-To: <YO8edjd9/2bDz3sO@kroah.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=d1380149-683d-4081-b93d-3c898b8894ed;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2021-07-14T21:17:39Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0e16f1e2-70b3-4f00-e1bd-08d9470d9235
x-ms-traffictypediagnostic: BYAPR21MB1621:
x-ms-exchange-transport-forked: True
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-microsoft-antispam-prvs: <BYAPR21MB1621E8593F5FFA3BB2153B73CE139@BYAPR21MB1621.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: LeH5BPHnocNDhlmbG0AloLdyWfGZBr6kq0JSVQhYzWTKYq8rGzlsYYxMw+z1qDRlUSZbEPpMuju4JEcS709+90vmIfoyv9kQY8hGrwrDzLkJafRxMI2H+NvgD5VT55jqw5WvYq9kAApFtvT4rUWzx2B+9FIiIS+voMy8FSsMChVMkLzg8PhveWfOXs9bgVwumDPWL3uxEHWX399Ye1uJFi/kwnWcaZmph9AduyD9AB2JrsdFedqniL+qLUXIDKeu99arDZ53lOSkUafTyHPptZAjw+SlTIOe3sd7njvOyjm8ZiT/vYxHsCzDXV8RPzxYFzCSVGJSCBaQdZPFN7hcuHmn663aqiSL7I7EihXoO0hAxosBa1bXBryRQz/z9N5tf0kt5qU8zZ0aL4jBxxnlB+6M8e07ZE8H73N2TtztjyMFHS2rbiFf85NYK7zaQs8Epbc5lhKWGwhK9+MwQdl5CKfIdzmy8PoX2v1yCb7PaX4QCT6RDo0WphtwNEERYv2urPcsKQOISWCajItZKF5KExWUy237aCZVraVoiTg1sUBanT4kkzlUMzj0ZFFwn1zVQYdeaoWnBw2VE0qCRP6+3wpttk3wXOegQQKFCyVuitCzLh5RCZZ67GMTe60qDT+MFZ1p8UB2/wRCh49GC1FC7nhJaTRkifkj9tfDR0OPYlAgkBHOFBQMDO+LQBfH2lxvWKAQybnykhPoe7iy+MgxUKgYiIqaMxfuScvqL0qv4GAYBoIuCPe7cSsux3dAxs10PazWSLt3zaAJYYFfzmZ9mBfhdFrxqRhXA0ywGgYm15FJ7zwqr0UsyxHucuPZo+SYTziIXRKf8L4BghCwrIaXgA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR21MB1506.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(478600001)(2906002)(82960400001)(5660300002)(55016002)(9686003)(52536014)(26005)(966005)(8676002)(82950400001)(186003)(33656002)(64756008)(86362001)(54906003)(7416002)(7696005)(10290500003)(66556008)(66476007)(76116006)(110136005)(316002)(83380400001)(8936002)(66946007)(6506007)(71200400001)(66446008)(8990500004)(122000001)(38100700002)(4326008)(38070700004);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?EQ7A0audXdnassOur/BLaPLUUDrQH6p6vnxThqSWeVS6JONP0oYZ1+lVbM1a?=
 =?us-ascii?Q?KWExxNInhmr3ZBJ69RJAIdyCeA9xFWEupA+s9YGZzvQj7xewMMX4jcYxJoxH?=
 =?us-ascii?Q?SzrViFS/1V3QUVTziEo6jLOcYoK0eiJPN7ba0JtwF4iWg2wc3YMv2YMBrKtJ?=
 =?us-ascii?Q?SUHQtckUrNIQaVSgqJwWzXeFYbsR+FL99uoTrpGKBFa1xu5wbpU4/n7kLIWZ?=
 =?us-ascii?Q?a7yKTPt1onN2F14Ea99YrDFFwKvRNu49DH4s2tba768QudisR2w521Sc6us9?=
 =?us-ascii?Q?CgxN4Ewd3ZjRxwcN7J7UxVZ1pbmVX6Hfc6Xpwcbwjy8rjQtWvK3BVjBoY1Kd?=
 =?us-ascii?Q?JHntrPAki3UGW9ZGhkTNHrGCOCLj2lgQDZE7h91VSO6YeL1YAh8x6QLd/TQI?=
 =?us-ascii?Q?XvxD8P/QJPHg4lmgHhxhAfS7FbkmR7x3jRmtToLHJ6xXO3HqrmTX2U+Csq7n?=
 =?us-ascii?Q?qhtj7PotiUAQybbCmrlGIm57zseMKFbBbMUL6uSiIn4/ZPUfaDUv21yCn+GX?=
 =?us-ascii?Q?wb3QGR+ockVoqVuR11addU2SAYwgaN5SXxEEzTyyaJqmIVInEucocHVzFJpj?=
 =?us-ascii?Q?2NgJPCROJJr+1iMWBEoH5aOHYemK0KIbjvjYLB0orFJrYVfJ1O47DBvZqqu1?=
 =?us-ascii?Q?5SshggUYLVhtOXJxkw+xoCEPXaeRVYPPlI0Ms3gSm8t0DpaYVTva/YIw6v/2?=
 =?us-ascii?Q?qQHNZIG4xps6bcgXsa6E36NESrdSGd4v2xOrI+yCRnjey03u/cupvXBmYl/I?=
 =?us-ascii?Q?SAa69v5e34xHdgsXztr32CuBspOg4DG1RnuKGi3HP53F2WU2FnLA51gPK5PW?=
 =?us-ascii?Q?3K85CfhpUYVl4KxQfqFGfIn27jjwXYkZohEZuOB/d9UR1ehPAD5Lwl+Fw0Q9?=
 =?us-ascii?Q?1l8QqxiErLEfXhZSG5hWvqwUVTIGwnLNsFWMIyX3oojPP1ApfzR7Rt7kqHBF?=
 =?us-ascii?Q?y9EBe9RQpSb7G30PTxFY9KhiwmHq//kmd2lQ7D/bkl66P+xi7LawWaOtC/v0?=
 =?us-ascii?Q?pVdNRSoPRyAm+ikG2tfRmWbadIHziGKy9qfvxf5CycL0nckmu8OV4N2p1tyx?=
 =?us-ascii?Q?xAyLDJ2s9J0uDkFHVX20/lK3RQn0350hksC4SovNMDlmghgB4nTz/gIRA/uP?=
 =?us-ascii?Q?cCbuCefoI23nUBffHNWAHIfWmvfm4NebbBzkPA5ujFSs7D+Sqd40jar8qQOl?=
 =?us-ascii?Q?8jqh0bqOFfhk++9QJ40JPf7vFzSX0PYyeHDDCKEIAWkHgVU+JRuXObsQfbGu?=
 =?us-ascii?Q?EhhGSI7VlGo8Jsg9B/GfRcn79Egz7QH81CQi43WSOZbfpiVOXlAmSTHFUuFI?=
 =?us-ascii?Q?M34=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR21MB1506.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e16f1e2-70b3-4f00-e1bd-08d9470d9235
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jul 2021 21:23:06.0796
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tDx8jyuWARlnQH74w2nbICGO8bQE4XZwW09Zg5ItFgNx903FnszNOneh8KGwa43/nUG7qFju8CpaMEmKIR7jYg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR21MB1621
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

> Subject: Re: [Patch v3 2/3] Drivers: hv: add Azure Blob driver
>=20
> On Tue, Jul 13, 2021 at 07:45:21PM -0700, longli@linuxonhyperv.com wrote:
> > From: Long Li <longli@microsoft.com>
> >
> > Azure Blob storage provides scalable and durable data storage for Azure=
.
> >
> (https://nam06.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fazu
> > re.microsoft.com%2Fen-
> us%2Fservices%2Fstorage%2Fblobs%2F&amp;data=3D04%7
> >
> C01%7Clongli%40microsoft.com%7Ccb3aaf42b6744c4a565e08d946eca3e1%7C
> 72f9
> >
> 88bf86f141af91ab2d7cd011db47%7C1%7C0%7C637618804484490378%7CUnk
> nown%7C
> >
> TWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiL
> CJXVC
> >
> I6Mn0%3D%7C1000&amp;sdata=3DXcAiTOWwDUWM7z2qt80vBL0YuS%2BdzsM
> 6T9JhVzcK8n
> > U%3D&amp;reserved=3D0)
> >
> > This driver adds support for accelerated access to Azure Blob storage.
> > As an alternative to REST APIs, it provides a fast data path that uses
> > host native network stack and secure direct data link for storage serve=
r
> access.
>=20
> Where is the userspace code that interacts with this driver through your
> custom ioctl interface?

The user-space code is being developed on all supported languages for Blob =
access,
and will be placed in the github:
https://github.com/Azure/azure-sdk

I will add that information to the patch.

Long

>=20
> thanks,
>=20
> greg k-h
