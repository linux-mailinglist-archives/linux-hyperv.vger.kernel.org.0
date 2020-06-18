Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EDFF31FFB27
	for <lists+linux-hyperv@lfdr.de>; Thu, 18 Jun 2020 20:35:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726879AbgFRSfw (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 18 Jun 2020 14:35:52 -0400
Received: from mail-eopbgr680097.outbound.protection.outlook.com ([40.107.68.97]:60782
        "EHLO NAM04-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725829AbgFRSfv (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 18 Jun 2020 14:35:51 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dyX+mREuUjMVbPZSGj9LubYpxUeeTrAVvPFl/E0eRBr5jitHQKt0c5ij2ndZY9ydbGh3oj+7Uc6+KacTfXPvPy8L3BPRC7fK4V6N8k9pI+M1dA3iRF4BZPI9ZxrNIkd2UspvfxJ3BjrLOM4THpC6fh2uIA3LM9Hf33hiF716SJbkdv2jGD8J9U6dAbAMYU5+S+7vll4L/4BQxlOEN+DthNGFQJnK2AVZx+Y8dcWHPpNn04lz4SjH11p13vn2jNM3G1Gjs0pfK9UzRAFDWiBnxAqfNY8gFJkXig7O3+bBUeM2WJmdUT0y/NbW5r8PVcIeBfmWF8snNO/PjIrXLdzNtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=macoh30GcHzUwiwEupAIwZmPHT2vFp9WJcnINa9tqQk=;
 b=nj4ASSg+ijejVu8FbZQUJx62+bs9KVJxaDETw7lGu4c9TjcWcpR+AHtTG9JwUemeYgxPZiGQAyLe2luQqmvipHXjd1jxWQx66HPj3QF/TDAISnwY3UBaZcw/MoX1+Bui9yrjXmBx1n5Pm9rOKGlqQ4nTfNdwrBAmO5QMtAaBIxUE0Mds6zlPf4wndRDDlu5ZM402IUgUJGCRs0nc/D52HvmtoBdfw9sUnp3lG/g0iWRB4UCjPEjF+vdn6TpVUI13wFxIRs41RU4sNLa5sUwY6snTjSww2tg4StDkb34NtqB+sMzh0ZbDtx5D/VBB/aj8u/BQFPmLn6kYFykW3I18tw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=macoh30GcHzUwiwEupAIwZmPHT2vFp9WJcnINa9tqQk=;
 b=cWg3SkZe9LCJ5zVtEAejN1MRPu+GkQaxehd460Ps+lDcaC/wSsw9ZcnZhHpKMn25bLFiwbvpNg+whcMQ3PzNSWGGg0v7xa/kSGVG1GYwet64FIXDHLL7lxD4A4jgtit3+bo3apApNCvfSLsMkS8oQeGC+LbA6aTzmmWciNn9Gho=
Received: from DM5PR2101MB1047.namprd21.prod.outlook.com (2603:10b6:4:9e::16)
 by DM5PR2101MB0901.namprd21.prod.outlook.com (2603:10b6:4:a7::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3131.10; Thu, 18 Jun
 2020 18:35:48 +0000
Received: from DM5PR2101MB1047.namprd21.prod.outlook.com
 ([fe80::9583:a05a:e040:2923]) by DM5PR2101MB1047.namprd21.prod.outlook.com
 ([fe80::9583:a05a:e040:2923%7]) with mapi id 15.20.3131.008; Thu, 18 Jun 2020
 18:35:48 +0000
From:   Michael Kelley <mikelley@microsoft.com>
To:     "Andrea Parri (Microsoft)" <parri.andrea@gmail.com>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>
CC:     "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 8/8] Drivers: hv: vmbus: Remove the lock field from the
 vmbus_channel struct
Thread-Topic: [PATCH 8/8] Drivers: hv: vmbus: Remove the lock field from the
 vmbus_channel struct
Thread-Index: AQHWRMcVcPX5lQ3H5EGpCHlG5Hj+0qjetLbg
Date:   Thu, 18 Jun 2020 18:35:48 +0000
Message-ID: <DM5PR2101MB10472446CC72A17FE2A78920D79B0@DM5PR2101MB1047.namprd21.prod.outlook.com>
References: <20200617164642.37393-1-parri.andrea@gmail.com>
 <20200617164642.37393-9-parri.andrea@gmail.com>
In-Reply-To: <20200617164642.37393-9-parri.andrea@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2020-06-18T18:35:46Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=f3a08f4b-6371-4394-b484-942cd0500616;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=microsoft.com;
x-originating-ip: [24.22.167.197]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 7c97e513-39ee-4964-3ae0-08d813b66ba1
x-ms-traffictypediagnostic: DM5PR2101MB0901:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM5PR2101MB0901108F5EF126FDE32EB5CCD79B0@DM5PR2101MB0901.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4125;
x-forefront-prvs: 0438F90F17
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: TwpR6fRzRY2755JAQc3cXol3FgdQbTeLMaGV8qxHsUCCZx/xBd/fMBXHHlvMXzAYfsZ/o1WpPtF+IHUXP6PY9Iq7VbWQmfWy5uGGTrWJhlvbn/DbdNQSqs5bTh37Avs6jxyP0JzP+nvRn/lAw11NwKo2yIAzgT5978hByjyRBOE75xePD1DVQXM2/lQmKk2k5oMac6FQI8T/UiDnCxv4WNmKb3ZhaZ8MSAt7BD2dnXKwGX/SNnZBvMQvdevmb3BKfmgzqRjB+eEir5law/HB8b2GYoPf0M3TRMalQJa/ZV4Uq3rYcYRWRmxe8WmSjjOOlQcTIzcX5RzxyKvGy+dsjw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR2101MB1047.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(136003)(366004)(376002)(346002)(39860400002)(396003)(8936002)(7696005)(8676002)(4744005)(82960400001)(82950400001)(26005)(4326008)(478600001)(6506007)(83380400001)(10290500003)(186003)(9686003)(110136005)(54906003)(52536014)(55016002)(5660300002)(71200400001)(316002)(8990500004)(76116006)(33656002)(66476007)(64756008)(66946007)(66556008)(66446008)(2906002)(86362001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: as+ccboSMaxYGnStE4zvxEYvmD/xhw549qRCztgTW+eW/ll1K0Qyokf89++yYU7YRgUDUTmR+sXvuHYacpMKOlWrNEsijxDrnP9JqpE3bk0PRWz156oejxFYIgbWvy09WQLovH1UHXgVUTW9SsLsj0o+myyMjMFWgCCfVMLbXJsca3qH0/nyH51l9jNFEsDRKeTkmMzinWQKRlcWFCBG+a/uVQ8VbXx4weA4BHkYu4MtYAGO6jRN8gfoeEplS54PrCbnIyK5BSBcn+usWGnwdTHhvD0+1OJmQKWf10GVYz0JXag/OGabpAcSuFLdAILW5A5VhJxcRRUHw2oqhHebbMuUbinQ8LKbXf/YC/A7TjJpwwJnxyTy0MJj1phoRdsaZAMOLqgZ9ALcujdrGDFVswoCPnphzIeqcFDEBaadXZS/jwsYsdUIzauXaY5OIJ7chbUUptcPgl7O89DfFI+D3K0Eph7vDLw9l0zwbD0KBJsOkjYirOcy9ePEVl7wKBqb
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR2101MB1047.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c97e513-39ee-4964-3ae0-08d813b66ba1
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jun 2020 18:35:48.2915
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SowbS1FsM6/2SVK2MSjwHDIC28+EhWytQQzM1mHgc+hwfxtQWQGFPaba0vAYENbN6UKiNIkM7fS/+bez+gwT2xgJYTk406AO4nP/a4l6pBA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0901
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

From: Andrea Parri (Microsoft) <parri.andrea@gmail.com>  Sent: Wednesday, J=
une 17, 2020 9:47 AM
>=20
> The spinlock is (now) *not used to protect test-and-set accesses
> to attributes of the structure or sc_list operations.
>=20
> There is, AFAICT, a distinct lack of {WRITE,READ}_ONCE()s in the
> handling of channel->state, but the changes below do not seem to
> make things "worse".  ;-)
>=20
> Signed-off-by: Andrea Parri (Microsoft) <parri.andrea@gmail.com>
> ---
>  drivers/hv/channel.c      | 6 +-----
>  drivers/hv/channel_mgmt.c | 1 -
>  include/linux/hyperv.h    | 6 ------
>  3 files changed, 1 insertion(+), 12 deletions(-)
>=20

Reviewed-by: Michael Kelley <mikelley@microsoft.com>
