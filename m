Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F96476BD22
	for <lists+linux-hyperv@lfdr.de>; Tue,  1 Aug 2023 20:59:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231955AbjHAS71 (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 1 Aug 2023 14:59:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231174AbjHAS7L (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 1 Aug 2023 14:59:11 -0400
Received: from HK2P15301CU002.outbound.protection.outlook.com (mail-eastasiaazon11020026.outbound.protection.outlook.com [52.101.128.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F0E630FD;
        Tue,  1 Aug 2023 11:59:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JjnZscF7dUCqSb8cpDlA1yo39YtArKzJkDA98vC2QAaCzFsPXsLmmEfdw6/I9RFGaZ8BIXvfcdKvJWan6/ZCHEqfV7ClKSy+QV3xe7IXGxcxHstsFTC2QnFrQlvEQ8vfRZJ5n97NHEtJzTK1gUiaJRa1OGd6VxVfeiKU82OwvncwcpjOoZ8e3pvswxVctknJc29PlvVZ+zzXn/n6A8mQ9Z+mczvHq+LJL9zRfOF1v6u24wy/+kk+meXX1Hnf2mfuNClOBNgq8lVaIYws+URwVdm9e1JATITK19/kzThYadxk0PBJRrbRRjacM9mjOndujIAj2mxDEPr7d/QNTFVArw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yyZnRkjFcxuO72vSQ7sqL3MJqlLUkh1g7aKtHvzPwK0=;
 b=n4esBWdtOOpfC2kk1wD5g0BnfaNQfv+6Wu5u1QM4Ulsji2PaO1HyJYVoftD3U32avl2L15ZWzXs+QLZXXPXHsNk/BZyFLbCJk1YEwpCZWdzsJIq1BQLp6WdiTV4JQbKxoK0QLKXHjHpAgXZiKzZBvS1ZY3lyEeiDdbBr0Jvxjv47ELx6upocxIRHY9CFjaLxLDuEx1CPqjgTpxDYa/7lmdJAiOQVSJDWTYxkmpb53JS/xrcJOMSg8RBW6ZFgXLEoFEXS8Fp/sRyWG6NgEzBuH/LObzYDk+69axmP9zaNhgChMWVU1ToDZJFXA3/1zzLpUYLlGOgRhnrP5fl4zj6d/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yyZnRkjFcxuO72vSQ7sqL3MJqlLUkh1g7aKtHvzPwK0=;
 b=Is2WPE07rO8Fn/FynX/wqQAwx5qN3wfb0QyOPT13iYJUMRN5EBGZFHO2WIH6zLFBxaPZSgda4Q8rH71M+xH1YcuYQM7LnND0e1FscvfOjtlUhQ4IiQHNdZ3EPnOvdJiNkY6elKaLRrVPkijTMfRydoebH83LFVy/Bo2TEeHmivQ=
Received: from PUZP153MB0788.APCP153.PROD.OUTLOOK.COM (2603:1096:301:fc::10)
 by SEZP153MB0661.APCP153.PROD.OUTLOOK.COM (2603:1096:101:90::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.6; Tue, 1 Aug
 2023 18:58:55 +0000
Received: from PUZP153MB0788.APCP153.PROD.OUTLOOK.COM
 ([fe80::abe0:95e:5348:dd5a]) by PUZP153MB0788.APCP153.PROD.OUTLOOK.COM
 ([fe80::abe0:95e:5348:dd5a%4]) with mapi id 15.20.6652.000; Tue, 1 Aug 2023
 18:58:55 +0000
From:   Souradeep Chakrabarti <schakrabarti@microsoft.com>
To:     Simon Horman <horms@kernel.org>,
        Souradeep Chakrabarti <schakrabarti@linux.microsoft.com>
CC:     KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
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
        vkuznets <vkuznets@redhat.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: RE: [EXTERNAL] Re: [PATCH V7 net] net: mana: Fix MANA VF unload when
 hardware is
Thread-Topic: [EXTERNAL] Re: [PATCH V7 net] net: mana: Fix MANA VF unload when
 hardware is
Thread-Index: AQHZxHPmLqz8YNs1vkSBwVqcY/Jzsa/VkZOAgAA5yLA=
Date:   Tue, 1 Aug 2023 18:58:54 +0000
Message-ID: <PUZP153MB0788A2C4FC7A76D2CDD021BCCC0AA@PUZP153MB0788.APCP153.PROD.OUTLOOK.COM>
References: <1690892953-25201-1-git-send-email-schakrabarti@linux.microsoft.com>
 <ZMklUch+vfZBqfAr@kernel.org>
In-Reply-To: <ZMklUch+vfZBqfAr@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=dbb12665-10db-4bbd-b9e7-2272f750161e;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2023-08-01T18:58:17Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PUZP153MB0788:EE_|SEZP153MB0661:EE_
x-ms-office365-filtering-correlation-id: 992b8c53-22ff-4194-e1ea-08db92c15a7c
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 06NYu8jpO0OA3Tb4+pf9U5CWOnlmChCfnLUKe9HJt6MH9p2AccBhO6LA4N4q4KYbsuGUkMZFAD98UxCHE7q7jDUJ4h3lpTgB7w+Saswt9WT8cg5vEuVveSoMoxyzx2QWG1C2kmJZySY1+89LXl1XUqvSmxjIoCyCfo3stf/LufKOKlEA0nXX/sTCfoKn8Uq/fAUXcB6R/x9GrDMC5CLY2WrVzlRJ6oFNsiskhM8ljgtgl8KVm178A16o6X8ILWNHhWwD4AN6Bs47dAAttfL7VZbmc47HQ7baw90+DSZGP45aYgdkjuIrWrCVEtg31oHP24IjCvbTtGi6sSG+G2m5rEFvVfmZmHG67lcnkKlDk+b8CmNQhNoqminTmxD6DtkC2p1b6tO5DDw4jR/gYYbmmUMlVtk9khzMltOCaCF/EHAJU3g1jDr2eTWPP0xJwlOYcJBOIgSxKqJ0dI3Q1EoE6C2/YwVCPOkT2gYcjWaOd/3G0njUttQJLypngXek2SdC1uDdFlIMxH26rJREbWdIU7uuDzknaYt7Ohg2jvxhjNcjH/se42x0WEu1aus6hBO0vdYi4pDg+3A6wDd+Aw21qn9m4KwFjcytghaVGmuks7oGnkMIHImt4fG7ltZNcVizLb8V0PxyzeVd6x/9Nn2NflHEVyby1ewFVVTMuAIS3Vw=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZP153MB0788.APCP153.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(346002)(376002)(136003)(396003)(366004)(451199021)(66946007)(10290500003)(66556008)(66446008)(4326008)(64756008)(786003)(66476007)(316002)(71200400001)(76116006)(38070700005)(41300700001)(122000001)(54906003)(33656002)(7696005)(9686003)(110136005)(478600001)(8676002)(8936002)(7416002)(52536014)(5660300002)(82960400001)(55016003)(82950400001)(6506007)(86362001)(83380400001)(26005)(186003)(2906002)(8990500004)(38100700002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?XEUWnItZkNol4OUEuP5wlJsbxMB4eDry8XZ5KbM57kfRM0I/A74o/zk2Jj7Y?=
 =?us-ascii?Q?2HF6jsSfmm7oO3vULBzReraJvyRgJOhYvvy3Sd1zknmw8S/Sb0QIg1nInG5a?=
 =?us-ascii?Q?dCcj3rPNs/GrKLFiDQuHhZ2LLvGTVz9ax4SLezerP/2T9I+5h3u9r0rIp86r?=
 =?us-ascii?Q?ozWy5PBYg4WFzDHYnPgjG6UUvFAJINqed00e01SR48haaWhlwEvP1q9GAC/E?=
 =?us-ascii?Q?Re6p5vVzQYmDpTy+H3RpLf0Rwnkno0fIhqrQNNYHG5d2kQeT04i15Q6gn3km?=
 =?us-ascii?Q?wLuGff648HTX+yfa29Q0COyN+hUVGSsAiBcaiqSuyv/DmD/LAAvXhv/teLxa?=
 =?us-ascii?Q?vrHRty5OV3+yok3cDH9Cwxina6ITmjYSntBpuipa9yw7mgB3BvHlXONrLm0Q?=
 =?us-ascii?Q?eolW/A3VqCrXORxlLyi1WMYdUrtAiksnE7x+GNkE3hoedgKaT9ZzTq8q+tmD?=
 =?us-ascii?Q?siUyGgXP1rOOf6Mayh3/vi+o4O6cikS+SdXR2/ZBdld9EshfOnefBQ2t8GAQ?=
 =?us-ascii?Q?+5k7I9xpY9SK3QyjjJnr3ZAThEVMfPV/srhMZVhIgrGLkhfEI0XECukWRBzn?=
 =?us-ascii?Q?5ZC4Qwx+N/Sn5Ha3VBxucMYy7gSEpG8hQQDzCf40Xv+y7jYHwKe8rCUVbPF8?=
 =?us-ascii?Q?fqemzR9RHw/VRW1wxU1z82CTziv0GmYnsKMoWX86GZYlqqueW1G0d/LF2UYY?=
 =?us-ascii?Q?c9fWmoCb8UpJO4quqnoooUDdf58YA68Y8nMTb5rKTJZeBhOSXI7tO2H67ixA?=
 =?us-ascii?Q?/HBaOIKdYoKynD9DHwSMYQr93adh0qFuTee6RIKT3xYPtOwCgc0bdm/s+2h7?=
 =?us-ascii?Q?2U6rwun3K9Rda6ntw4TEkLMf45VYyOvWYCvQwv9m+vmjLIYVCnHK4VYNRfkH?=
 =?us-ascii?Q?TPPsjuIMyaxPQ9Xu7f4heX/643TZ+UXLN0Qpo1dpkOT+XQCrWrGV/S10BoCc?=
 =?us-ascii?Q?ylf7HqwgpWzVEsV4SS9bQHGTmXenBxU7fUiWEvc8lbLIAiufrT+hDJ2fb234?=
 =?us-ascii?Q?gQAmrRa8qCWy/i0o4LLhzof/s1JkZOhWaDNDm8gIPGsu+0Mtvp7xEjMwHEAS?=
 =?us-ascii?Q?lhPv6Suk1U47G5IT7sXd/jlCpfyrFkFcSkcdq1XPDOLqAOxaLeIG44lURFFX?=
 =?us-ascii?Q?rKZ3tLF7iwYvbUYTrSzeLYaML6bhZ3yq3Oj8XArGnh5zLUNowC38wl+4xMbx?=
 =?us-ascii?Q?iRr8xw4hTO2hIxj7tsgJ/sbvLnEWYSUGXcKezQ5hhDio/0opfAZ7fUMkpp5V?=
 =?us-ascii?Q?k+I7X4lfsKHfnQLNw9crkfKrSQe/AXBIOOfE3TEIzncNa+UW6uijSyQ5JuG7?=
 =?us-ascii?Q?JvJMMppBZ2YndpgNsYgeQdwNHJ3vQzDnDzhcu8mtRO52qvOkhSS46uCkotO9?=
 =?us-ascii?Q?4ouuKPh7kqYdWE+8n0jBxroz6+nrudDTeDi7Unq8+5Qqi4veK/YID2Gj2Ef1?=
 =?us-ascii?Q?8awRzjOojEqgPnR/II8EQXZj/xtg0o1BHAt6bfIcpRrlQ5XLZXkmbg1IxfaE?=
 =?us-ascii?Q?LgjVP0EZl+l70KdEQLHlzUQpCYs3V6ObTsOE?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PUZP153MB0788.APCP153.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 992b8c53-22ff-4194-e1ea-08db92c15a7c
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Aug 2023 18:58:54.7200
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: aOREfljvjFxid3xsw4/M9G7JnTK8KuWb8qnQdVjm8z7KsCAEYA/azMwFUfMQpXMi8q+I6v20lT4clC4WCb0qDP7Jro+5bL16OguFqdtyIxk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZP153MB0661
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org



>-----Original Message-----
>From: Simon Horman <horms@kernel.org>
>Sent: Tuesday, August 1, 2023 9:01 PM
>To: Souradeep Chakrabarti <schakrabarti@linux.microsoft.com>
>Cc: KY Srinivasan <kys@microsoft.com>; Haiyang Zhang
><haiyangz@microsoft.com>; wei.liu@kernel.org; Dexuan Cui
><decui@microsoft.com>; davem@davemloft.net; edumazet@google.com;
>kuba@kernel.org; pabeni@redhat.com; Long Li <longli@microsoft.com>; Ajay
>Sharma <sharmaajay@microsoft.com>; leon@kernel.org;
>cai.huoqing@linux.dev; ssengar@linux.microsoft.com; vkuznets
><vkuznets@redhat.com>; tglx@linutronix.de; linux-hyperv@vger.kernel.org;
>netdev@vger.kernel.org; linux-kernel@vger.kernel.org; linux-
>rdma@vger.kernel.org; Souradeep Chakrabarti
><schakrabarti@microsoft.com>; stable@vger.kernel.org
>Subject: [EXTERNAL] Re: [PATCH V7 net] net: mana: Fix MANA VF unload when
>hardware is
>
>On Tue, Aug 01, 2023 at 05:29:13AM -0700, Souradeep Chakrabarti wrote:
>
>...
>
>Hi Souradeep,
>
>
>> +	for (i =3D 0; i < apc->num_queues; i++) {
>> +		txq =3D &apc->tx_qp[i].txq;
>> +		while (skb =3D skb_dequeue(&txq->pending_skbs)) {
>
>W=3D1 builds with both clang-16 and gcc-12 complain that they would like a=
n
>extra set of parentheses around an assignment used as a truth value.
Thanks for letting me know. I will fix it in next version.
>
>> +			mana_unmap_skb(skb, apc);
>> +			dev_consume_skb_any(skb);
>> +		}
>> +		atomic_set(&txq->pending_sends, 0);
>> +	}
>>  	/* We're 100% sure the queues can no longer be woken up, because
>>  	 * we're sure now mana_poll_tx_cq() can't be running.
>>  	 */
>> --
>> 2.34.1
>>
>>
