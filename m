Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A66AC3AA4FF
	for <lists+linux-hyperv@lfdr.de>; Wed, 16 Jun 2021 22:11:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233220AbhFPUNL (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 16 Jun 2021 16:13:11 -0400
Received: from mail-mw2nam12on2125.outbound.protection.outlook.com ([40.107.244.125]:30176
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233140AbhFPUM7 (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 16 Jun 2021 16:12:59 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OO2k82F2zwZmWRH9K/tX3zstkeUGgySfAp7ZLk7Ouc9hDZakY3KQCnvayDpElAQstY1hlca3JtGmpZs8almfZuykSQFi4twfdV6IYBwaGlT03rVhWbzPus3uULXEJYKDxNOyVYUAKxUKZSVGYnxKZAYgiZluQxlmawoNeWGCRazacp4IEr9yYeVClkACNlmxYCAHj0HNQ3d3Rk6jhgHnqnhuTm+LCjWyLd3IVeCtEAcJUMfaTVFdOFw6mqhHziJCYgVhatmnzPwaYB/YUiP1QkARUrEr3zSjzzfp9loxRaluTHKoEGuf+2Pfsz6pH7/QV77we47dqlYe1GSyJ443OA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+LctrhXnaztUsv/jHvN/CFMqN3nc6Xa6rAEaTA1VXb4=;
 b=NVX4I0Nbdvlrl2m2UuI0VjBei9oHmmjfIw2udy7NJgz13IimzIH+bOwqIp55kOeHrLm+0LzP057dbrkXpCkQsBopfXthkw93uOnL+3Ao2E2jfgndVyW+KsLepfSYouNsq6F4+PL5+n0PV4CWw0NF+Bz61S0mDg6xJoloBuRvfDCv0SfHQtoF/j8ZjL5H4hhA/nqnov458QA3uDf9eYOJQ2/iMbHgW7tl5ovnrnCgmGhu3rOEGtRraFcB3KrFyUXbicAgR4K2c0eOIOD0GS7pgHQiGjA1h0W6Iv2zqLQ2ycGIZZl71X8917REEnoaPTF8pGlicVK1NcK3VVVIRq+Zgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+LctrhXnaztUsv/jHvN/CFMqN3nc6Xa6rAEaTA1VXb4=;
 b=dVjAYHMBlpLOODbKtOVaF8UZD5ZO7tfZvdrBCjmbgDh0kZTsVdc0x5tOlfa2tAovIhMjlOOdSm5PMbkzJEHceQ6Wsh0AXKWVpHCxANopF1m2i2+Whpr+cazw6jWHDTeYTiTzc7wekOLAzW+ubv/fUvS5aUrPAUXV3HwjZPHm0U4=
Received: from MWHPR21MB1593.namprd21.prod.outlook.com (2603:10b6:301:7c::11)
 by MW2PR2101MB1817.namprd21.prod.outlook.com (2603:10b6:302:d::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4264.2; Wed, 16 Jun
 2021 20:10:50 +0000
Received: from MWHPR21MB1593.namprd21.prod.outlook.com
 ([fe80::55bf:85c:1abe:d168]) by MWHPR21MB1593.namprd21.prod.outlook.com
 ([fe80::55bf:85c:1abe:d168%8]) with mapi id 15.20.4264.004; Wed, 16 Jun 2021
 20:10:50 +0000
From:   Michael Kelley <mikelley@microsoft.com>
To:     "Martin K. Petersen" <martin.petersen@oracle.com>
CC:     KY Srinivasan <kys@microsoft.com>, Long Li <longli@microsoft.com>,
        "wei.liu@kernel.org" <wei.liu@kernel.org>,
        "jejb@linux.ibm.com" <jejb@linux.ibm.com>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>
Subject: RE: [PATCH 1/3] scsi: storvsc: Miscellaneous code cleanups
Thread-Topic: [PATCH 1/3] scsi: storvsc: Miscellaneous code cleanups
Thread-Index: AQHXWWYIAsJ2zwF+KkecbXYDITXaOKsV+udwgAEjtUCAAATt+IAAAENQ
Date:   Wed, 16 Jun 2021 20:10:50 +0000
Message-ID: <MWHPR21MB159365DE648C8911E6AA53D2D70F9@MWHPR21MB1593.namprd21.prod.outlook.com>
References: <1622827263-12516-1-git-send-email-mikelley@microsoft.com>
        <yq135ti7em1.fsf@ca-mkp.ca.oracle.com>
        <MWHPR21MB1593ABC5154A199022896D3ED70F9@MWHPR21MB1593.namprd21.prod.outlook.com>
 <yq1lf794m98.fsf@ca-mkp.ca.oracle.com>
In-Reply-To: <yq1lf794m98.fsf@ca-mkp.ca.oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=b9081cde-da2c-4c2c-a25d-b0a62e34cf37;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2021-06-16T20:07:56Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: oracle.com; dkim=none (message not signed)
 header.d=none;oracle.com; dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ff91b02b-f3cd-4535-2b75-08d93102d66f
x-ms-traffictypediagnostic: MW2PR2101MB1817:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MW2PR2101MB1817C72E242A16010A158FB8D70F9@MW2PR2101MB1817.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: On/aeNKJRqf0XM2nTJoFd6KTWDCbMcZ8kUBxzivtwGo5xWHgS3rt+3N4zgyDwr5j90umYbEmVKd0zXlSi1wNNPYnm5XkcsgD2A0hQq/tAjCQuBvImOr3prXxKw3PvRB71it+V1zsy8kOwyfpDKyByqSevQYIZlXfB5A74RvC6EOClF2nruRRCqBaQylY1RteSxnf9dk+JRQeRDW9FTZp9x493k82U1IRGpsCQSMKrXYiWVsec+PY1bT7ywvZQoyKjppx6pvm4s1ZR3aF+vKgussEzhap9nPQLNoQ30FT8XhnoPjrtBLcvPHSPWJMc42dHdrmCYswyYF9+NgFNfbRB/FN4ATvWXA4EIdLp5DrJrIx9ejjV07p3d+BY45QFUA9ddyOKGQ03EAwKlNJBEgjrC3mLBZZEtmmimUORR4gSEOR6iFoCTrCgs5IvwRhsM0XmthEzssvPVWq0tZcCBYy+pc9kIvVok0yxmb3PITkZ03G9VK9MWyYYVLiQg+zBs3tjeE+0KSoUPhs2wWWsk/L7bb+X0lsLMWuXVfGDklEx4CwgsOGe2lIj72wkcoRrF7BPC4h86FoDa/CdoUULL8iEXYPhEc2Rft1JeXPrOpt8vFO0mVHDmQZPFhgVaB4n7Let+qiLzehUx/CnlbMHEzkPA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR21MB1593.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(316002)(6916009)(186003)(5660300002)(8936002)(54906003)(52536014)(33656002)(9686003)(122000001)(8676002)(82960400001)(4744005)(82950400001)(4326008)(55016002)(38100700002)(83380400001)(66476007)(7696005)(66556008)(66446008)(64756008)(478600001)(10290500003)(76116006)(2906002)(71200400001)(8990500004)(66946007)(6506007)(86362001)(26005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?xTXloEbR3zU2GEcbjMH6JkH05TGHLLQoBdGJ2GId3eJ2JH5CWixbZx3f9rNd?=
 =?us-ascii?Q?SSz7/92mtSDwJndpLDbVZZvpvyNTR+zeoPaELWBAVn1SG/rPf0m6HvnEcdh8?=
 =?us-ascii?Q?IK10sYp847FWOjLKbLi6aDXfdvIeuceHzVWZ0ebQUaJJW1jlv41gof/V/myg?=
 =?us-ascii?Q?rrhdW5hDb8LPnipKPsIl6zMquhMjVmFYJndY1Yh6VjOzxFnaLqrXEnRuYGnS?=
 =?us-ascii?Q?vvzze6pBh/5jZq97AqlC2ec53xB5CrFAaz51ey+Hc5cYxLl007SAJg4gDAWZ?=
 =?us-ascii?Q?jMsav2ZnaLkcuvDLImG0aMTZoAB4hm5CTj91iQ5rwGHEx7Rm8HdTcrDVajbX?=
 =?us-ascii?Q?9JMA7ti85lWqTBPeA1HNAyrxSAQXwQGicMgvj9wZmM/hOfFOnWt1Cas/5O49?=
 =?us-ascii?Q?tU5iwI8dIYlCpkP6qnnO8oAEXj43RdsKFtEBWivLwEJ7O75GBGht8OxwDki4?=
 =?us-ascii?Q?wiRB1xptUAG/bWjPj1fG07mcPlgNIBsknBq6+HYtBKGkcND9b5yWBysqmvL7?=
 =?us-ascii?Q?1ebi0+sqsFcbVxCj0vzBlS2YCofXZRce6giU2dw5GaCd1M+DggHSx8QyOo4t?=
 =?us-ascii?Q?YWx4d9gjju7FOuZTAxR6O/7gRLb/PSeP1CZMrfdwCN5DtV8gM08rVr5v5tOe?=
 =?us-ascii?Q?I2+ajn2R43MCFuhdIuez+BfHF7R2dg+vh7/kA2lD2Cea3EmU84ZMFx83s527?=
 =?us-ascii?Q?2y46rvxyhm508inMq0O4M+gFU25kQAaqb+ZIM/o8nRvELNHytB86IDxP9Cu/?=
 =?us-ascii?Q?Fm9+HYYUfwYK7tnC8tmT+8fRYWqWJr+7kzIAvFnFvBIybpkUuoAp6kTPirHy?=
 =?us-ascii?Q?ndBOQ3gWp6H04VwodFnLaXhDhSb78C5yMiuDKauLyv15XtlVBio5RPUygsgT?=
 =?us-ascii?Q?B9asDvxFLyAGjA2wipVqAxnU7rXtjeykGtpGSB+OuW7p8Y6BufJfx2oX4jXK?=
 =?us-ascii?Q?YncoJPzUPCRDTc5LHSRqNJgFPK+lpNZP30WA+AeJYsrn9VX4DrO64tKmrY7D?=
 =?us-ascii?Q?xsbxWsaM6fBgyJ3KwtAsHHeYAvES+H/IcWag1aScCq08jYbfdLn7yjmP5f8S?=
 =?us-ascii?Q?1HpUIvRnmWLr1FDNngI5MdJO9NItC59Cz8Rog0Sdd3TMjEqOclUK7nq66CAv?=
 =?us-ascii?Q?w0dkDquCQEcRPT4CY8dQaOMHBCFB55j2C0iYl8UlpISE/mod/HwXF627p0V1?=
 =?us-ascii?Q?szP1SQmwflguyrO/un2WHVHcxTXppMWqM1sR4eDQ/z7hVPvKhLDoo/+MU4wg?=
 =?us-ascii?Q?hP1qAuMJMn9fbXlm/bWHUgwy9zcibH8MtSsEq4u/uP6vbsNwmjCzeZlnXz7b?=
 =?us-ascii?Q?OZhxNrmYcYo77tEG1uAhmFEk?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR21MB1593.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ff91b02b-f3cd-4535-2b75-08d93102d66f
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jun 2021 20:10:50.5901
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ngUp86qm+LRDCcNdNkeYu8o+aIUZZ8v/1uEoRScbJ1PZplwsoXiL22OTii7Yme7iZUv2VRtau0Zh3ng8WimRuSflM2R+ll2rsDeA8t+cePY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR2101MB1817
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

From: Martin K. Petersen <martin.petersen@oracle.com> Sent: Wednesday, June=
 16, 2021 1:07 PM
>=20
> > Unfortunately, it's not quite right.  The line of code in question
> > needs to be
> >
> > if ((vstor_packet->vm_srb.scsi_status & 0xFF) =3D=3D SAM_STAT_CHECK_CON=
DITION &&
>=20
> > The status_byte() helper was doing the masking as well as the right
> > shift, so the masking will need to be open coded.
>=20
> CHECK_CONDITION is obsolete so no shifting is required for the SAM
> status. And as far as I can tell vm_srb.scsi_status is a u8:
>=20
> struct vmscsi_request {
>         u16 length;
>         u8 srb_status;
>         u8 scsi_status;
> [...]
>=20

Indeed, you are right!  I was trying to preserve the masking with 0xFF
from the original code before my patch, but that masking was
spurious.  :-(   So yes, it's good.

Thanks,

Michael


