Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85CD873E3FE
	for <lists+linux-hyperv@lfdr.de>; Mon, 26 Jun 2023 17:53:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231565AbjFZPx5 (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 26 Jun 2023 11:53:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231543AbjFZPx4 (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 26 Jun 2023 11:53:56 -0400
Received: from BN6PR00CU002.outbound.protection.outlook.com (mail-eastus2azon11021020.outbound.protection.outlook.com [52.101.57.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8F0B125;
        Mon, 26 Jun 2023 08:53:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NxXDqrMsoE2NaThctWvx4x/ORzOldR1yu3EltQrtpsdIGiw9yUw6sS0T5ejcMAXSQ/9Dj5QtKrX+cAjaeErnZe2ZkasfAtJq30eQ/xxICK86+lUaamfpKagwSPtyu/Ge4uFruXdj1avhp+LcUzkJGccMeIW4TqP8mX8GmJhDBUcuTpjkHYvC6dFtWVxeMX9+L8xaj6bPi3PnJDyYEJ1CRV33wIZqojfoq6Ib7fS4aVQBlNJXyVAqKUIwtDkPY+GoPzxyKTURUVzgjkFovLgzk5op4AJoH4BgUcJzA5FSdIl3Eewi+IVEjgiBf1vI9u64Rv+ffSFw2T8xU89y0ROR1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FygOVKJR2p0iN+NzlfH3B3OVq/eFqFjKPzjVQTkgdPg=;
 b=Sm1zZB+CuJ00Xvzuckko6YrloEKy8MbgEl2+mTmKqU/XRkkQmaxKxUAk99SX+19K1+7IpJ6dToUqc6AyZ7E769okwoHfH9CiYX9WSQBufJAYK8tPXHQT4bNM4enPk+NaFSTMQqog8X2VMQBIiOyHzeeFdxYqJRgg6kA6M6WKXSqoiPEuma0RfxFpjk7rudX1bjObD+e01wqgxRzHNnlkAREeLgY72xVLzbfm3hRyyA7Y06xJ00EtCQB78Q+UJUdkrj2yY90Nh9suUsM47lX7ClWrsSU+5UrQVr2EvFezbItLaAnU58P43qB72GOKtY3g13+wQpNTXRD3FMS1EGitvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FygOVKJR2p0iN+NzlfH3B3OVq/eFqFjKPzjVQTkgdPg=;
 b=P0aeeajs3UK+q7tPBC8ZJWaMUfkrQovlVNTf0o/4fCGrRcCvv646d8dscevLeurZAiSPGckcbltcfSt61rRwDxTx+ETMzGGIvajvQMBPchxvMTbEPZDG+vZkWsZf+xaYL+I3Md8MCgMdqX3SrfB0NG0s2KNbODt2IgtCMjYgVuo=
Received: from PH7PR21MB3116.namprd21.prod.outlook.com (2603:10b6:510:1d0::10)
 by PH0PR21MB1960.namprd21.prod.outlook.com (2603:10b6:510:8::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.2; Mon, 26 Jun
 2023 15:53:50 +0000
Received: from PH7PR21MB3116.namprd21.prod.outlook.com
 ([fe80::848b:6d47:841d:20ff]) by PH7PR21MB3116.namprd21.prod.outlook.com
 ([fe80::848b:6d47:841d:20ff%4]) with mapi id 15.20.6544.006; Mon, 26 Jun 2023
 15:53:50 +0000
From:   Haiyang Zhang <haiyangz@microsoft.com>
To:     souradeep chakrabarti <schakrabarti@linux.microsoft.com>,
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
Thread-Index: AQHZqA9znbKK9TI41UWeQtXPI5JlLq+dO3pg
Date:   Mon, 26 Jun 2023 15:53:50 +0000
Message-ID: <PH7PR21MB3116B7C4826A19F3103D6304CA26A@PH7PR21MB3116.namprd21.prod.outlook.com>
References: <1687771098-26775-1-git-send-email-schakrabarti@linux.microsoft.com>
 <1687771224-27162-1-git-send-email-schakrabarti@linux.microsoft.com>
In-Reply-To: <1687771224-27162-1-git-send-email-schakrabarti@linux.microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=c963369e-5bff-4e95-b72e-b907236e87f7;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2023-06-26T15:49:32Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR21MB3116:EE_|PH0PR21MB1960:EE_
x-ms-office365-filtering-correlation-id: 62e23cee-9b5c-4a35-2332-08db765d88fc
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: SfSYx8ScOsZD4QGyYBXApoKxdZA9N34FlLxUNBa9LanYSBZhD/tOWAsx5LsuxnNSOZLodbybTyGl6FbF2M7iU7wftXvbmEUfBdGPyPuEzTCteikFXss6G7YPTRQhvc+jAVAqlm6pDz+vAAQQ7bPZXh1/gKAXcoHxHIErnGzrSIXxT2HO9TQxcj0VeLWjeL7bi0r/9wkWqf4urbZ5Ive2OXBaBoAzrZlM/Y5iha4QYzs+NE0J8X+MSJZ6zEbBSz8WQQ+ilfGa9aZFeVdnCOaLnuiLAhLbARbMZ709zoA/bOpSAhwJ33HucZVPLHWt9XD+iICFbC35fwe8hnrrm3pRJ5hseS5SNRmqWMnpxD1Y8HVUDyiK2HjxabJHZ240qSXRdC2vLrBqfmnU2I7OFXYDt8w6rE9NYpVCKXWOI5ZNlHkTNmrZi2Sj32bzltVEBz/EJYpgzRi2KNKmPO24WrOpIr5H7srR81YfRUGiXP+RiFDW0AnjSFFeAbR7gSyu5ZTZV7uJB2eRGPN6rTEqOKFzirLVIQSB9vsbf3EogIEPAgZgVdi1h2WRUdd9a82eCFPmYQ8O88b2E7ytxmqTwN6y1oPmIa0qphfMc+eRLij4n9IPId89Nj5T1ag1NYIiZyLyBbF6IyLv5gp5qLDwil/qm6O1DhUcQU55Q+qv0jvYExmegWpXcsI6RrVI30A9XsFg
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR21MB3116.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(366004)(396003)(39860400002)(136003)(346002)(451199021)(7416002)(76116006)(4326008)(66556008)(33656002)(66446008)(66946007)(64756008)(66476007)(10290500003)(478600001)(2906002)(316002)(8676002)(8936002)(52536014)(5660300002)(55016003)(110136005)(54906003)(41300700001)(38070700005)(8990500004)(86362001)(7696005)(4744005)(9686003)(53546011)(6506007)(26005)(186003)(38100700002)(82960400001)(921005)(82950400001)(71200400001)(122000001)(107886003)(83380400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?RpaLTpZsSR8Fdrks+jzIx6NcBXldN/UVnDy1GCKTG7HJ8ugD6sZ3pQVi19Bj?=
 =?us-ascii?Q?neYjJO0UTItOG77BFZfvUPIjfVdsRegBJGBszMUQaGzAIhdxkJNtRIqyHv0s?=
 =?us-ascii?Q?WpcI+3FE8P25amm9TU6XmZWkVGuGa2nfvtIcwmJppX5c8NFhikvtGIYFOpAe?=
 =?us-ascii?Q?9Mo8bGDfajaitm6IVWoQ4Z2Bcm+UIsn+r/aUoUlT2ddjDE22JqUCJaReJP7q?=
 =?us-ascii?Q?wVMbp0EgaUQt/meh7tYxhCE1UVfvBRrxfnhLYUxZ5hJ8NlRSRUTh7lwzJaJ0?=
 =?us-ascii?Q?8ZXZx6lfKrxNuCE+GTxqwoTjggKKP1nsyHV+9XlpX53+Vn+7yYHA/BZbrrWW?=
 =?us-ascii?Q?BD1QaKmTh5x7Jb1yhbcqmXsSJSrSeexcR2DzGFefxkpc+AU6slr5Yk65gyO9?=
 =?us-ascii?Q?/X8Yhxn7o8r3K9oXypefAhL3GyclYBp4LarF/00zAPgDEr7i/MzM6mIcLI8T?=
 =?us-ascii?Q?yOFcKlRXZbPIEZsNvGIL/cVcCapdBGbjRfl+p80RtXh7olD74qgTNbgeZ4wo?=
 =?us-ascii?Q?gMRPMomuEXJAyIuYPwwYOrFsPI9n8wslE2/Lv8esjoWl8CPGjoX1RYdaODpn?=
 =?us-ascii?Q?0kNXHpMO59k90TOP5yGMh/JQY2FDVUBq1aJ2AoKoqfG95CQz66gYSQwu6ZQF?=
 =?us-ascii?Q?TpmARDR09SK/3RvrvndttiSpOmoZEwX0BsAXtKzO0iW8unMGcw4bWPs1ihHh?=
 =?us-ascii?Q?sOVOO6quzKQIRI5YK6ebHCiau5BFZWjNUcXxFSzObLgzDas+L9yV9jr78WU1?=
 =?us-ascii?Q?J7SMWNbR/0BE1jSrhX4sIoYK6F6Q2iHAnf4XQfOjaThEKtVGmgWKhMVChW+H?=
 =?us-ascii?Q?b1UunI3hZducZo9xDuj+qbraRzjTNjXgGFPKYpWih29V5atjZTRXsMEtkopG?=
 =?us-ascii?Q?AJEc5zOoJMAJAWYB22rOL8gpn6FdLhOz3KRTbE/Dt8ytmP7bcCeCZYCLPJSq?=
 =?us-ascii?Q?YdpojoLIMEALWbnBJyis9lWs0WEFPfjCe7XRjsnZB2I/RFouPZi9V3d6iRKJ?=
 =?us-ascii?Q?PTaKuCxe9tAqHVTtXreG4vGqjLBe0ufbpkQIPpAP0RG2Iv+qH5N+PMcYz8yx?=
 =?us-ascii?Q?qBL2oAdx4SURijncZlhPIMuIkm6Og9T+Ii0dAl+LFukZKHVyVin1Z03dVQNL?=
 =?us-ascii?Q?1m78GhT8t3J5zbB7dThHNnn5PnRsSfT+bS6fOWdvix0PYc+CtPUG836NbhqI?=
 =?us-ascii?Q?WdoUxC81X7UeVCCaJVDBptbZnlAcv/skX4zxutVBXn923VrNEjslOKktftjj?=
 =?us-ascii?Q?Ebh5ORKFAwXERrqwXpEqDgGP2J6ww0x0o+JpDzNn3tsVKVW3w1ZKVMUCOOOy?=
 =?us-ascii?Q?q/INdn3bajcwqU2Se2qLK8oFgTnKDp1pM75mh4rd1i82Oy/TaNefJni+GVAV?=
 =?us-ascii?Q?ymwbHuYphs7odYMhh4yrxD7CWwUN3ScaQZL0wNriX1rJ3EQlfcNFCRiNnYsv?=
 =?us-ascii?Q?xyvtS7wgSHLXBO1IocvmSg+D3hJkWeWo1g8vepNz6vNT1earlT+7DyUQx1pg?=
 =?us-ascii?Q?5gvjsT6DM22Tii6vzLfyn7W6Z4euRki8cPKSvk2mjOe7vjNXBUsqJTimDGdj?=
 =?us-ascii?Q?bwCpayrYQ20/SGr6zH+kkLT4fbei5DCuButD4Pb9?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR21MB3116.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 62e23cee-9b5c-4a35-2332-08db765d88fc
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jun 2023 15:53:50.5307
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wfgAHtVO6tAJnYYzsgqlsadvwY2A4z2Cfd2IgpgoEuwnEc8zGLQA4OaWTcjpBoqTbxcV0YQF4jApLOd/NU1pSA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR21MB1960
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
> From: souradeep chakrabarti <schakrabarti@linux.microsoft.com>
> Sent: Monday, June 26, 2023 5:20 AM
> To: KY Srinivasan <kys@microsoft.com>; Haiyang Zhang
> <haiyangz@microsoft.com>; wei.liu@kernel.org; Dexuan Cui
> <decui@microsoft.com>; davem@davemloft.net; edumazet@google.com;
> kuba@kernel.org; pabeni@redhat.com; Long Li <longli@microsoft.com>; Ajay
> Sharma <sharmaajay@microsoft.com>; leon@kernel.org;
> cai.huoqing@linux.dev; ssengar@linux.microsoft.com; vkuznets@redhat.com;
> tglx@linutronix.de; linux-hyperv@vger.kernel.org; netdev@vger.kernel.org;
> linux-kernel@vger.kernel.org; linux-rdma@vger.kernel.org
> Cc: stable@vger.kernel.org; Souradeep Chakrabarti
> <schakrabarti@microsoft.com>; Souradeep Chakrabarti
> <schakrabarti@linux.microsoft.com>
> Subject: [PATCH 2/2 V3 net] net: mana: Fix MANA VF unload when host is
> unresponsive

In general, two patches shouldn't have the same Subject.

For this patch set, the two patches are two steps to fix the unloading issu=
e, and
they are not very long. IMHO, they should be in one patch.

Thanks,
- Haiyang

