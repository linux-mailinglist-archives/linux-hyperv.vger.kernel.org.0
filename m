Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC89D73EB96
	for <lists+linux-hyperv@lfdr.de>; Mon, 26 Jun 2023 22:13:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232266AbjFZUHY (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 26 Jun 2023 16:07:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232314AbjFZUHI (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 26 Jun 2023 16:07:08 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2120.outbound.protection.outlook.com [40.107.220.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC9C326B8;
        Mon, 26 Jun 2023 13:06:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mOzxS2ZTw3e0zYG1e8FubLtUEZ2mJrkiatpj22MeJzLBLeOpU/MkPaI/AUiVo+OO08A3NoKbVcwTI7CVrLxyOb0GBktHHXDQA6lqJ8z5EwELjZ4Blboi3AvO5AVv2oKjH2Fla0OZhV3UY5qBJaVB1Odz0gQOrbiWRoFuslobAsgouHwFnQA3GL111w/PSojhF8Lf5ALg/v0l2cKh1PBDwbpke+XmsaZq79T5RFtdAErmrBKXruI7XGdch1H7fS3bvyWf7JqUTPoJMzRzEuku8FFpzu+txDAsJLONKvLw/A4ilSM5X3cOk/Fxq2WZci8fDFfHzVCTnqQjlQwWvjKEUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ruPzvesSQ+3VO1Spa3EJk0mMOszZePXzRyvK5NMJodA=;
 b=Ao15awfjh6X0c0OZdOw7eNsRO0jn/MuA3NHyAuHuFAgb/ABzPpJrhj8In5STr1rZb8wNshOvVsfhomwZDu+Qr3AHMNqyYI634oopgXlVpqU8U/ROjKfa4PJmvxfrR1ve92oneFvkUkJ/3rC5Y20T9bKbSMvQ/OhzcfThCnYV9hTVsH538CQEokL363VaB9iDQLa3AT7UHVBqn0vFZUzwDs8e8vdr5SoWx9xOMW7ToyvLt801bxjzBewQN4+dMArR+8UeAw+3f9FGwUnr7L3srytHzOnIbHoYNpQIKjY0XrhpF5afS2/wkmJuKAhklDVwBGLsxXT/y4ODqUeTSQ2S3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ruPzvesSQ+3VO1Spa3EJk0mMOszZePXzRyvK5NMJodA=;
 b=cc1Orrq4aUYWErxUFwPe2uXgiZFxvAWVrdRhXtI6ilDj/tIebLap76UVjKNRmeYX6ZHKBHh3+P5uSAT+0hJwVAPI1Gw+JkGk/0d1HCJHTmSgYDnjsfRqMTTZ+x3vLWDh8dwsAkyUXviVnGeY3S90nnS58irLGGFSlHGQNvjahBw=
Received: from SA1PR21MB1335.namprd21.prod.outlook.com (2603:10b6:806:1f2::11)
 by MW4PR21MB1890.namprd21.prod.outlook.com (2603:10b6:303:64::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.1; Mon, 26 Jun
 2023 20:06:48 +0000
Received: from SA1PR21MB1335.namprd21.prod.outlook.com
 ([fe80::bb03:96fc:3397:6022]) by SA1PR21MB1335.namprd21.prod.outlook.com
 ([fe80::bb03:96fc:3397:6022%4]) with mapi id 15.20.6565.001; Mon, 26 Jun 2023
 20:06:48 +0000
From:   Dexuan Cui <decui@microsoft.com>
To:     Simon Horman <simon.horman@corigine.com>,
        souradeep chakrabarti <schakrabarti@linux.microsoft.com>
CC:     KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        "wei.liu@kernel.org" <wei.liu@kernel.org>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "edumazet@google.com" <edumazet@google.com>,
        "kuba@kernel.org" <kuba@kernel.org>,
        "pabeni@redhat.com" <pabeni@redhat.com>,
        Long Li <longli@microsoft.com>,
        Ajay Sharma <sharmaajay@microsoft.com>,
        "leon@kernel.org" <leon@kernel.org>,
        "cai.huoqing@linux.dev" <cai.huoqing@linux.dev>,
        "ssengar@linux.microsoft.com" <ssengar@linux.microsoft.com>,
        "vkuznets@redhat.com" <vkuznets@redhat.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        Souradeep Chakrabarti <schakrabarti@microsoft.com>
Subject: RE: [PATCH 1/2 V3 net] net: mana: Fix MANA VF unload when host is
 unresponsive
Thread-Topic: [PATCH 1/2 V3 net] net: mana: Fix MANA VF unload when host is
 unresponsive
Thread-Index: AQHZqA8qvg9EaL0msEmv63j+Ft5wna+dDYsAgAB04AA=
Date:   Mon, 26 Jun 2023 20:06:48 +0000
Message-ID: <SA1PR21MB1335166153541BFDC2B7036BBF26A@SA1PR21MB1335.namprd21.prod.outlook.com>
References: <1687771058-26634-1-git-send-email-schakrabarti@linux.microsoft.com>
 <1687771098-26775-1-git-send-email-schakrabarti@linux.microsoft.com>
 <ZJmNBKA3ygDryP7i@corigine.com>
In-Reply-To: <ZJmNBKA3ygDryP7i@corigine.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=9bb960f3-ba18-4d6b-9ec8-9fd729d3f924;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2023-06-26T20:03:26Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR21MB1335:EE_|MW4PR21MB1890:EE_
x-ms-office365-filtering-correlation-id: 9f036f76-5527-4a2f-6e4e-08db7680dfc7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: j6x0msGIjuTge8YCcS1n4Kz85BTyKCzEvyNckaL/5wxY+fk7pe8tdFr/XGFZ2HKZwAbXLatlzpZY8LbDtNvJQ1ZgLeMqrnKEi9JouTpIPG7PXw3fkyK7LeYa4KwdiiXR+47DfxpJQQpkvqAFY0/DqMneMat6JrSC82a2cI2RM9l3hsllfCHy49/rzrBwLJjdYiEaJ7wDZLR5kSCCMDMizh7a2A21gx4LWOWzv1zLHapOHPbgTa03zhOOt/Jk/9rJb4zxn2pTNuJE1bk47MSck/V7kQYP3TX3tNkh5mzwaUbG8MKJWneTGLzipmwEwr7JTVGtrqltPUwIzUBT2Ith99KJeBYvTVLcByLQR9ym6QVDC1bgIyFUYD0Pt31tNblj3SqwLJuB5PQSdPZuhY3P+dZ4CZWuwTX64/q4ax05/w1RYIHPlVS0fbs0R+1WDMa/4/o3LY+dCMPRNVNYNdMnPS5GvbUNfROC8z6zaYbtrTAHcELMQ8WXcaojAVkhMq71ESeSTaX+QUYONcaOyg1GG+uyZFmegXgshX1x3ItMA6Qvl03afzaYVC/t3UHN1DDdG5/5UbLWxMUKC8Wb+LNc1RF9wZQF0cfzLbtU3c0q2c3bOFkh824/Ufxe+wLDEX01FPEgsG+x3k9M37rAZVbkLg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR21MB1335.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(366004)(346002)(396003)(136003)(39860400002)(451199021)(6506007)(7416002)(4326008)(66446008)(66946007)(66476007)(76116006)(64756008)(66556008)(33656002)(478600001)(10290500003)(316002)(2906002)(8676002)(8936002)(52536014)(5660300002)(966005)(110136005)(54906003)(55016003)(41300700001)(86362001)(8990500004)(38070700005)(7696005)(38100700002)(4744005)(186003)(9686003)(26005)(71200400001)(82960400001)(82950400001)(122000001)(107886003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?4kkKiywEFclMK5vwn29BtMJeD1C95w8w3Xm8wBeAL7uM8AsG77mEjineigoC?=
 =?us-ascii?Q?YgexxhFnGFinB14COlFFesDSMBmQGuhscNg+49q327LO8ZiIzSNTj4WVeZmD?=
 =?us-ascii?Q?ndXq4RcLph4+9C11v8pUuE6dBvP+4Zv1D0X7I9ljDN6mpJYMOn12Hspa+pMT?=
 =?us-ascii?Q?glSE95SqjJmVqmREiQpgjkLj14yemjTojGiUVopZP/nzp945axCdZkZ29ol1?=
 =?us-ascii?Q?RkgO1InXnEtYBM51K3F251gHFa6NoKu3tqaLB9caoeswTD0OKieQA4WcMhA3?=
 =?us-ascii?Q?bsbS7Q658h8uxTb4bayEHJ6pZd6p9g59UMmNH00wG4EURN+UkEq1sR8laVgN?=
 =?us-ascii?Q?QPZwbdEdeJAD0i+SnB61S3rTzmWGUE/efs/NWOrMvwOOpKzMktPvEFlEJfGb?=
 =?us-ascii?Q?/DT8hZdZCrtbRul8WeXbbJWI84DhBJYSsRZFmjU/JnsYEC8iEvE0imETq06d?=
 =?us-ascii?Q?/TuBR3vbBJwzqZWn+czyeV2vDdtIcy/NIKLTvlLRTcuIt6wNX8zmY4RE5/NT?=
 =?us-ascii?Q?hGGfg34fkdbGPb9qZB+lwe+1aBg4cMZQ+KncY+Onsop46cok24xY7fvTLsE9?=
 =?us-ascii?Q?41AJ6Qa2wxyeZLA5g65J6DVLvVEOGaKUOyJxxiU7/HZAOI+Acil7JZIXNecp?=
 =?us-ascii?Q?MIuiOTZNg9jlVeWr1hg4M1r4Hk4sGsCbfXf3ozaCnh/GcrkAN+zIrwn5DI51?=
 =?us-ascii?Q?ysQ94isLp+mu34KDbeRRaJTmWQDJ++uB0AehwSEdybg73JX3SqfYKFfCLzrm?=
 =?us-ascii?Q?fzHRMK8ofEaVknIP3Rnn/VnUJL+teK8SuGULu5zvyca4PsI4IbIbLAcyFpVy?=
 =?us-ascii?Q?9q6AaVOp2AXJVJdy+WmB2fzU47JF7Q6OK+cUIpXY3rPEXbX1fXfzZpcraIGY?=
 =?us-ascii?Q?dPOoxhXIPVKeD5D/j2fz038Gt7JsDYRAQl5xB6d5GpF7cohIeH1sqmN8HZPV?=
 =?us-ascii?Q?Mso2qjejcfyEGB78E4AFRCBGbwpYBxX4Sq+xUmwpi0yel1wSoXhjt5KCkW6v?=
 =?us-ascii?Q?UA1IhI3jgelYN+F0q02dNkfXOhVzI11HvzyIMr8mA49J2c5J1UirZt9qTCjd?=
 =?us-ascii?Q?Ztkdr7802/0sX1iYhjlsehArLT2UFnYHO+TgiwTclnsx8HuIwxhyIqoRtntT?=
 =?us-ascii?Q?Xc0m7vTWw3RgwPNgt/PNbxc3D9+5yQaqW8LYx+ApPEHLpLEeSI/8RUb5XE5i?=
 =?us-ascii?Q?i1cWI9YtqlJ5XZEeT3BGklJ2IVeUnTm2ll0VGabJKsU/S1K5p1O9BbatVRSa?=
 =?us-ascii?Q?iuMb9dHx3jw+bEETnVt1xkiGfcIbro1m9tWY84FuBPk0IvSdo4DI4qnXmjZA?=
 =?us-ascii?Q?VrrWuyw5q2Uw1YJm0lKpwVJ0UCLV/Af5wG4s7cIbwIy9whVHIVsX6bdUHtgN?=
 =?us-ascii?Q?jjlUsHWF3TywU8dUMEG3QBuS9t6XJdeUtPzuZTkamDqtz5iH+FaW8oa3TQb0?=
 =?us-ascii?Q?0eNaP4TiaKBaH9E/U/1lLIrAcwuurHYoo1Abz3bDKWEIdot/Yno5PuD3rb38?=
 =?us-ascii?Q?spIcKC8GIMt5spcaEhkpK+Fk8mR3lm2hLgFi/3jnT9sHRpxcVxNu4sjdrwtm?=
 =?us-ascii?Q?gJX1Y9r+Jxi6Psp6f+pqvECDrIvF0X7pbHFp6O9k?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR21MB1335.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f036f76-5527-4a2f-6e4e-08db7680dfc7
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jun 2023 20:06:48.5266
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jD0SaeqLw0s1yP4ZK0wehlOlqCUIMLp8Ngmc6F+kBhtPlNrPg2QiPleHp48qyruxhLaJ1ru8nhymAoTRAeuMPw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR21MB1890
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

> From: Simon Horman
> Sent: Monday, June 26, 2023 6:05 AM
> > ...
> > Fixes: ca9c54d2d6a5ab2430c4eda364c77125d62e5e0f (net: mana: Add a
> > driver for
> > Microsoft Azure Network Adapter)
>=20
> nit: A correct format of this fixes tag is:
>=20
> In particular:
> * All on lone line
> * Description in double quotes.
>=20
> Fixes: ca9c54d2d6a5 ("net: mana: Add a driver for Microsoft Azure Network
> Adapter (MANA)")

Hi Souradeep, FYI I often refer to:
https://marc.info/?l=3Dlinux-pci&m=3D150905742808166&w=3D2

The link mentions:
alias gsr=3D'git --no-pager show -s --abbrev-commit --abbrev=3D12 --pretty=
=3Dformat:"%h (\"%s\")%n"'

"gsr ca9c54d2d6a5ab2430c4eda364c77125d62e5e0f" produces:
ca9c54d2d6a5 ("net: mana: Add a driver for Microsoft Azure Network Adapter =
(MANA)")
