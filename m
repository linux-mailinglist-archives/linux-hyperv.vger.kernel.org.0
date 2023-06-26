Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F91573E40F
	for <lists+linux-hyperv@lfdr.de>; Mon, 26 Jun 2023 18:02:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231586AbjFZQCL (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 26 Jun 2023 12:02:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231540AbjFZQCK (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 26 Jun 2023 12:02:10 -0400
Received: from DM6FTOPR00CU001.outbound.protection.outlook.com (mail-centralusazon11020014.outbound.protection.outlook.com [52.101.61.14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AEA391;
        Mon, 26 Jun 2023 09:02:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fj4gwxH13ai4XF89Io9tf+C5lyXYEYeu4dFGpiUay4qDuvUqo/x0Mak9Nln/VtzOoIVYsak6y+6euaJYlhiFWcg6KjyYNcT3Mrc0xcwjGSVEStNN74NUgeiFbwK/nBhArl3KKZcUy3wnBXByO7YUKdhpYR5nq3s4dd3DyXyOS7bxuPLdjTM/syXSjHN6jPEPQkMnqezI9XXTIS3f3BeuRopINTcYTickWiGpZ/l9St5vrGyXjcJwH5DXg8Dg1LpnjiIjWRpiquNzSrbSZgb3tgXfYaWykdvWpW0osPd737qKukSR68fgMekIDb/reTywAl5YcVW0zG3aSzbCbGBI0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9pysYqN3p77Oy7WYowshijYDpU7VGapRtKkqRXXsDa4=;
 b=e+TcBtsNp0IRgAdBbyb6Yv1Hqtq7KL+QdD6wBcxGSQQmIgqstTKtjWQ7zvDYZZEKmqa+410ik9kvo2d6MlP4//XAY1n0oc/ETFAcfoXm2FV7g46FwdrL24XQ+xUhI5DQKuKi7cOCvBK2nU75VFtnH+h1j80nAjIVxatCTER/rpca2DvtlLbPZOpBxD8H5GJTxbx5X7NrS4uFCuDZ52M6FyJhFbSR7PWziPXxn2maCF5JPlgkZHH3xxo7+4mnOaogt1XuoAQ69lqWCcFtoUOPOi0CBhlTSh7sl3n7gLSZxsIRd0zefT8CdYB76gXnMNqFpNM5fvtAD2sgtkWXZeNxqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9pysYqN3p77Oy7WYowshijYDpU7VGapRtKkqRXXsDa4=;
 b=F5TG4znOUE8WqkJYCsjanyUQwfex0FJ8PCU7NP3IDFs2P8D3lrfoZpPjBaaiTQprU2IydstX45LQd0r2tMmhH3OPDgqGdl9/h8JWkX+DN7wj4S3p0vCvNSorUUZssK47s8Oju/xEwIXv5ZzDI5bsP9Ew5SuaWDaHwPYpCtoW8VA=
Received: from PH7PR21MB3116.namprd21.prod.outlook.com (2603:10b6:510:1d0::10)
 by DS7PR21MB3055.namprd21.prod.outlook.com (2603:10b6:8:73::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.5; Mon, 26 Jun
 2023 16:02:06 +0000
Received: from PH7PR21MB3116.namprd21.prod.outlook.com
 ([fe80::848b:6d47:841d:20ff]) by PH7PR21MB3116.namprd21.prod.outlook.com
 ([fe80::848b:6d47:841d:20ff%4]) with mapi id 15.20.6544.006; Mon, 26 Jun 2023
 16:02:05 +0000
From:   Haiyang Zhang <haiyangz@microsoft.com>
To:     Haiyang Zhang <haiyangz@microsoft.com>,
        souradeep chakrabarti <schakrabarti@linux.microsoft.com>,
        KY Srinivasan <kys@microsoft.com>,
        "wei.liu@kernel.org" <wei.liu@kernel.org>,
        Dexuan Cui <decui@microsoft.com>,
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
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
CC:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        Souradeep Chakrabarti <schakrabarti@microsoft.com>
Subject: RE: [PATCH 2/2 V3 net] net: mana: Fix MANA VF unload when host is
 unresponsive
Thread-Topic: [PATCH 2/2 V3 net] net: mana: Fix MANA VF unload when host is
 unresponsive
Thread-Index: AQHZqA9znbKK9TI41UWeQtXPI5JlLq+dO3pggAAB+BA=
Date:   Mon, 26 Jun 2023 16:02:05 +0000
Message-ID: <PH7PR21MB3116A07B1DA04FC36432B9B0CA26A@PH7PR21MB3116.namprd21.prod.outlook.com>
References: <1687771098-26775-1-git-send-email-schakrabarti@linux.microsoft.com>
 <1687771224-27162-1-git-send-email-schakrabarti@linux.microsoft.com>
 <PH7PR21MB3116B7C4826A19F3103D6304CA26A@PH7PR21MB3116.namprd21.prod.outlook.com>
In-Reply-To: <PH7PR21MB3116B7C4826A19F3103D6304CA26A@PH7PR21MB3116.namprd21.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=c963369e-5bff-4e95-b72e-b907236e87f7;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2023-06-26T15:49:32Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR21MB3116:EE_|DS7PR21MB3055:EE_
x-ms-office365-filtering-correlation-id: d564f7eb-093d-417a-e452-08db765eafff
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 7mIn6RFL4BwdOtRvBiCcKIeBdsAvzEQ/wfKOtdmdyU3Wzh3DUiKFVY1fgfFrWYV82RsF1z+qrCBwbpfrWq0YwBErNx61u8pqerPpgzKJKBQh2N+CxH7hlDOX9ThTavn76x1MOIGZ6ak4fpvN9r2AHDayq2vye1HE5+l/MjdOV9G7YM14eHIga/dt2wBoFWeS3rWnAkn7wmUoMb/q8V3ZKssLATRKw2UZ8nDSLvYSwVmdHa2rk2F37l746vRyPuzVGF81zQ/oBZLYek6NWbhh0x1nllDV9GYacVnR7ODXCQvpDdIN2z+xFwTfsr39sBtt4VggJJ9SfLxJe/hEPomYscFbR3NRtN4ckCfx1qv6r6TyFjNjPRWKcvmhxwGHXtLU+a0lJA8T9p/3e52nKC4Du8Yn5E5B4XwbmDd7/v+39ahRGKA//rjJXdIsblfopvr+eULSwkiH/NTlhU/zGG9AZmzUMkCjS8jZhX2/j9G4zJ9ON7dJYpkvgxASSU9p11y/PATU9spRb8mXXnfVLgXKHDLnwIp6dL6nUmvQaJFESUcbyxIECEVMgYLfwd+jDW2rupRfSEAKxMzkRoZe0nNOgwoCqdMJl7M5l8IHlGeHUj5VvdOMH9EbdkMMMSPOaXgqWd0H1OMkN8f4S97HHBnhlJ5b713OoMnXDf2PbLo+2HrfMAB7h9dHPW9+G2Z8BjZj
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR21MB3116.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(346002)(366004)(376002)(396003)(136003)(451199021)(2906002)(7696005)(921005)(82950400001)(82960400001)(38100700002)(107886003)(122000001)(71200400001)(83380400001)(6506007)(9686003)(53546011)(26005)(186003)(2940100002)(41300700001)(86362001)(55016003)(54906003)(8990500004)(110136005)(38070700005)(478600001)(66556008)(66476007)(66446008)(33656002)(316002)(66946007)(76116006)(4326008)(8936002)(8676002)(64756008)(52536014)(5660300002)(7416002)(10290500003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?goTWu7R86BuaafOBDTENlOBLRcHNhoM3vUipptoP8aEE8OwjLfjyeoKrPjms?=
 =?us-ascii?Q?i1U3XjxMhtfyVRW7T5YNjSwgqYObHDkdKqRnZFlwHRChWIbIaCbiJ/8TE1iQ?=
 =?us-ascii?Q?6XEvRajsbiRAwB2fXgUX63cEzHbN072r4a8KlU9v1LldYCeA3CqGlUDTnIIO?=
 =?us-ascii?Q?2/HQaeqThcVZgpz83LgdmLS9aWafxT0Aa+6A/Dzg5IV+jb7eVK12B9rA1YUw?=
 =?us-ascii?Q?Qm18XFYeoVxbhM38BC2iIZs4Wqqr0MyOcab1UCRLD7fd+xKW2tC3UhhXT2+l?=
 =?us-ascii?Q?cUmEiLZkVuaGr0Jm26lX7cDc2XsBjJ8tAHgm/2DfWCbf8fCaEMgaWiweLfFr?=
 =?us-ascii?Q?1OupWezeI2TL9CueshF8w1QxFnCM/c3hhltlZJixb9IpKLmv648Sbn8XpLGx?=
 =?us-ascii?Q?0o3+JXvkKxEGAIiRzpfVJxqT+OOeDzyclt8zdBcJJgfGvhehTtd/kRuDpy7/?=
 =?us-ascii?Q?1ghrCiv0+m865WbIRA4757UBhuF9hb/unJJ2H63J4UNv1KFLLRTC+d6qC4s0?=
 =?us-ascii?Q?2KVzvm2cur7b3Dzl2SSWSERla388zQLhpnyF3sQWw1jFMJv1CMt4vEWKWPm/?=
 =?us-ascii?Q?Vy3fI6LgGkSCil8NT3olzfbLZLBcaODd5N9AlheuUFW0IBZBGEzi/s7oiEMd?=
 =?us-ascii?Q?uaHs7S6tvQ2SlVn3Xd4yXLZARajCYfn7K8WXbKuqukPgKsD5jjl8X7nlWPyw?=
 =?us-ascii?Q?hpH91V5zkMu2WjrD6Jpf7GJDsZh4XFG/unWPKy3VPHVS1hn5nWkHG7N8azS0?=
 =?us-ascii?Q?JXM4KHLfz+HpAIy2DUnqRN+f/7aodI7hRd7hAy3PQT1KQ9RNd1t9XJ6+Khfv?=
 =?us-ascii?Q?iKHM9ZEKscySaSwsqwzVoA5xKk1lMhjieP3xKy+K7yNpoPma6YWHgW2NqHmT?=
 =?us-ascii?Q?c8nxCcnjYmOAOhJuuElu/Q3wUbO0M4lO5M+lh8RSSOjwKfI22b+YvklIyPIq?=
 =?us-ascii?Q?6So3lBi3E2xq7jttmNzf4V6jx2JXIEcP3UqX3aHj5Ydh1tfEkQ3dj0qXgTHn?=
 =?us-ascii?Q?idnOxUHJjA4aUuSV2CfMseTZbaP9hj8m+4WkuQrOQaSIaXxmjmcpo1QreOZ1?=
 =?us-ascii?Q?3+bmmUgrXmBqStP6OUj8N4LoDsURVZ0Z2F65Imx/iG92KNw4IX48Yro6Ju9B?=
 =?us-ascii?Q?iwLhHVG7VgTBcPnfSzbkrirOV7D3n6F0LFcL+asXHzJ2fPWki3kydWOw7jcb?=
 =?us-ascii?Q?YQRQZFGb5EjFUd5RdS4FRiWMF5RRrXUl/VETElCcHSwDVfCC3THcXDb0MwDE?=
 =?us-ascii?Q?UeoQc36t/Ha6YxoApAle+E8OSUJbx/4jr/YXTZ7SaTwgO04ZylYPsrPG7kvw?=
 =?us-ascii?Q?j4VRVBuhQLnEPseD11Id0KZw/mlDewnQy6E+EAel0cKf5DNPnQBggBPQklxD?=
 =?us-ascii?Q?w6Rei0QEW2DZIlnjZSVFjy3RHe8ygfpDZbTtP4S4oBPJTjtQHSKgjfDlJs3z?=
 =?us-ascii?Q?bcVrcEm72ytFBua2TEkg4M3NQ+pyk4aF4Xs83RhVkgZt4hBzbaBtaMYS0jqf?=
 =?us-ascii?Q?LqyAWqMQJpy4MT64YapVEEMlLiKC1rkBNOzG1kplNknQGfw9yB3772v+Pd+r?=
 =?us-ascii?Q?r8W4f+Ae5MmY3PZdfyjdKK5Vlxgc9+EMqksnWQyN?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR21MB3116.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d564f7eb-093d-417a-e452-08db765eafff
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jun 2023 16:02:05.4388
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OnE/I248Y4vAaXpwh5fJbpc5PCYC7J1Vg+V2Jt4ZSozC2fVJJVU25CqKqct5G5Fx/tZ1XyU2ZKpZOrVjWYYiVw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR21MB3055
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org



> -----Original Message-----
> From: Haiyang Zhang <haiyangz@microsoft.com>
> Sent: Monday, June 26, 2023 11:54 AM
> To: souradeep chakrabarti <schakrabarti@linux.microsoft.com>; KY Srinivas=
an
> <kys@microsoft.com>; wei.liu@kernel.org; Dexuan Cui
> <decui@microsoft.com>; davem@davemloft.net; edumazet@google.com;
> kuba@kernel.org; pabeni@redhat.com; Long Li <longli@microsoft.com>; Ajay
> Sharma <sharmaajay@microsoft.com>; leon@kernel.org;
> cai.huoqing@linux.dev; ssengar@linux.microsoft.com; vkuznets@redhat.com;
> tglx@linutronix.de; linux-hyperv@vger.kernel.org; netdev@vger.kernel.org;
> linux-kernel@vger.kernel.org; linux-rdma@vger.kernel.org
> Cc: stable@vger.kernel.org; Souradeep Chakrabarti
> <schakrabarti@microsoft.com>
> Subject: RE: [PATCH 2/2 V3 net] net: mana: Fix MANA VF unload when host i=
s
> unresponsive
>=20
>=20
>=20
> > -----Original Message-----
> > From: souradeep chakrabarti <schakrabarti@linux.microsoft.com>
> > Sent: Monday, June 26, 2023 5:20 AM
> > To: KY Srinivasan <kys@microsoft.com>; Haiyang Zhang
> > <haiyangz@microsoft.com>; wei.liu@kernel.org; Dexuan Cui
> > <decui@microsoft.com>; davem@davemloft.net; edumazet@google.com;
> > kuba@kernel.org; pabeni@redhat.com; Long Li <longli@microsoft.com>; Aja=
y
> > Sharma <sharmaajay@microsoft.com>; leon@kernel.org;
> > cai.huoqing@linux.dev; ssengar@linux.microsoft.com; vkuznets@redhat.com=
;
> > tglx@linutronix.de; linux-hyperv@vger.kernel.org; netdev@vger.kernel.or=
g;
> > linux-kernel@vger.kernel.org; linux-rdma@vger.kernel.org
> > Cc: stable@vger.kernel.org; Souradeep Chakrabarti
> > <schakrabarti@microsoft.com>; Souradeep Chakrabarti
> > <schakrabarti@linux.microsoft.com>
> > Subject: [PATCH 2/2 V3 net] net: mana: Fix MANA VF unload when host is
> > unresponsive
>=20
> In general, two patches shouldn't have the same Subject.
>=20

If two patches are preferred, please use more descriptive subjects like the=
se:

1/2: Fix the infinite waiting on pending_sends during host unresponsiveness
2/2: Avoid extra waits if host not responding in earlier steps

Thanks,
- Haiyang

