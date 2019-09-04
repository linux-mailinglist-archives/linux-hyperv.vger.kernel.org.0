Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A62F3A8D4A
	for <lists+linux-hyperv@lfdr.de>; Wed,  4 Sep 2019 21:31:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731383AbfIDQn5 (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 4 Sep 2019 12:43:57 -0400
Received: from mail-eopbgr710116.outbound.protection.outlook.com ([40.107.71.116]:15332
        "EHLO NAM05-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731719AbfIDQn5 (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 4 Sep 2019 12:43:57 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aUd0ZObi7Eb6XsgNP6jyymVCTdniWUB/DE/JadhZ5wCTPkdwY2TN5wUVqDM0O6Wxs3h7z3GgAJTC1zBX+I7wKW5N3Yb3POJO7kae9LTJyB1b6BOCOwnbBSxisO95hpaT+CJMImlBi5XUqMd9Fi7ba2ArqnpyaYuysY+cpxieIHkex67Lih311PwpvoANGmNSqAZUQjZJz1qZkEjqZ1pxVKjF1m8OqwpJ6srpK6agh0HO+Go2zi+yjojcui2q9h4LZbuJACrd1xGG+oHjDJ3s//zwN7Pwyu3zeB0vJ5fUvQJ1R8HulL9kka55okrPnFvYkBgLBPwV/6ujkuKa174lMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z+aRk4VAvRHYgsp3q8SLtdJe2ZdwRpFM5oS2pnUUTcE=;
 b=LAMD3Jg8HkZuUnG/19XlVW0rQiBaenfqbxuv9+pIB5ejD18BEu6lMWicLzbAoAtWwKqQhXWoFyVTweajDJHkw09H/5TC4hDRBRq145A62VU/E9kLXvOKjb4nJ+tOIGw5ykGCX+FyPohO7VTEnRZgJX+A2u9me7ToxhkmXHoTk1+m8w6l0f/j8B0rfBHifaReZdoS/lG/DewQRqKJaaHeLj4cAEFMiQ8gSWqcKehdtoHFru7gMC3d+iMsuq9dhw9/rX++8ccNKA6mavnw/FbLWZuL1bVRg+Iai9nO9XW33YJv9QfjRseJlD8EcNgqXovWTK2hjexzxjzyG5THfpmLYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z+aRk4VAvRHYgsp3q8SLtdJe2ZdwRpFM5oS2pnUUTcE=;
 b=kVXAxmEEkpHCD4mQrHQVrmzEqXMH++MuoHCcfvkN8UohfpAxZeGNx4/46wHeBte2DWwdgJH8zls6bY34vptv0Mc/ANSu0GB9UWgVuwgK+/+yyTP4wo8uJZ5TmLcQm5vLW913REox2jjATKoPSsJvp/3CN3qIj6VQHEI6F7sIx78=
Received: from DM5PR21MB0137.namprd21.prod.outlook.com (10.173.173.12) by
 DM5PR21MB0635.namprd21.prod.outlook.com (10.175.111.142) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2263.6; Wed, 4 Sep 2019 16:43:54 +0000
Received: from DM5PR21MB0137.namprd21.prod.outlook.com
 ([fe80::c437:6219:efcc:fb8a]) by DM5PR21MB0137.namprd21.prod.outlook.com
 ([fe80::c437:6219:efcc:fb8a%7]) with mapi id 15.20.2263.004; Wed, 4 Sep 2019
 16:43:54 +0000
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
Subject: RE: [PATCH v4 08/12] Drivers: hv: vmbus: Ignore the offers when
 resuming from hibernation
Thread-Topic: [PATCH v4 08/12] Drivers: hv: vmbus: Ignore the offers when
 resuming from hibernation
Thread-Index: AQHVYe3MQlcEYNcqeUeKCjb0mmWYXqcbu9tw
Date:   Wed, 4 Sep 2019 16:43:54 +0000
Message-ID: <DM5PR21MB013748F2C85496977B03827AD7B80@DM5PR21MB0137.namprd21.prod.outlook.com>
References: <1567470139-119355-1-git-send-email-decui@microsoft.com>
 <1567470139-119355-9-git-send-email-decui@microsoft.com>
In-Reply-To: <1567470139-119355-9-git-send-email-decui@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Owner=mikelley@ntdev.microsoft.com;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2019-09-04T16:43:53.1462228Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=8fd59133-635f-4a5e-88f0-1aeb8dd39f96;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Extended_MSFT_Method=Automatic
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=mikelley@microsoft.com; 
x-originating-ip: [2001:4898:80e8:a:c9a6:edf8:bca3:c905]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 33e9adab-8643-493b-801d-08d73157131a
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:DM5PR21MB0635;
x-ms-traffictypediagnostic: DM5PR21MB0635:|DM5PR21MB0635:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM5PR21MB063567EB5D0170E750299A1BD7B80@DM5PR21MB0635.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6430;
x-forefront-prvs: 0150F3F97D
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(376002)(396003)(366004)(136003)(346002)(39860400002)(189003)(199004)(5660300002)(102836004)(2501003)(186003)(1511001)(55016002)(81156014)(81166006)(8936002)(229853002)(4326008)(6506007)(76176011)(8990500004)(25786009)(8676002)(476003)(11346002)(9686003)(446003)(33656002)(53936002)(6116002)(10090500001)(486006)(6436002)(74316002)(6246003)(52536014)(7736002)(305945005)(14454004)(22452003)(99286004)(7696005)(46003)(14444005)(2201001)(10290500003)(2906002)(256004)(316002)(86362001)(110136005)(4744005)(66446008)(71200400001)(71190400001)(66946007)(478600001)(66556008)(64756008)(66476007)(76116006);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR21MB0635;H:DM5PR21MB0137.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 4cH2LoWqCCBARXrWz3FzrmP4jbyxXgGfY2P9+p2GpbXF/r++b1OXjbv/u+3jP+a1aIxXkZnSPTj+kiXkMVgYFuDXfCnbYejsmwfo0hDJeMmSPuGmuWQ+aTWOCNtxtcKIna76cXvGV2OUjtgoJ0hYEBARxP+qgdx8NcVoFv8XnmQSZpts2751KvR7keeflzSO3kX+6eQjpnTaEyfYHgeQ13KGFzmRS9+UokP10bH8XVAbXZBFXS/r9A4ReBPPePsxgMYfD8zC1lCQ+BZGbUJe7rtx3y7VCM7Z7LWnejX0zYkPGlVkUCcY45E/BivcDBW67LDRXrZ1TF0sxw9D4XXMHxvt6iQP47k2GykH44/lSFyhQSdLz9rvWg/H4Hlpb2qa0Cu6hew3mMvXCPsDsA8rnGKsXsqETFoGAR6ka9WcNcU=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 33e9adab-8643-493b-801d-08d73157131a
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Sep 2019 16:43:54.7994
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vtXglKFS1aIXtDMnFM0VHPV/kT5TdoACo4oEsf4xy2U4+eLgrXYaW2RwsuGGTgAN49KFq9UqoerIlO0VJEYPfH/lPVJSIzTjvnO73b9l1tY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR21MB0635
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

From: Dexuan Cui <decui@microsoft.com> Sent: Monday, September 2, 2019 5:23=
 PM
>=20
> When the VM resumes, the host re-sends the offers. We should not add the
> offers to the global vmbus_connection.chn_list again.
>=20
> This patch assumes the RELIDs of the channels don't change across
> hibernation. Actually this is not always true, especially in the case of
> NIC SR-IOV the VF vmbus device's RELID sometimes can change. A later patc=
h
> will address this issue by mapping the new offers to the old channels and
> fixing up the old channels, if necessary.
>=20
> Signed-off-by: Dexuan Cui <decui@microsoft.com>
> ---
>  drivers/hv/channel_mgmt.c | 58
> ++++++++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 57 insertions(+), 1 deletion(-)
>=20

Reviewed-by: Michael Kelley <mikelley@microsoft.com>
