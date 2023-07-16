Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8AA967550E0
	for <lists+linux-hyperv@lfdr.de>; Sun, 16 Jul 2023 21:13:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229519AbjGPTNX (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Sun, 16 Jul 2023 15:13:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229591AbjGPTNW (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Sun, 16 Jul 2023 15:13:22 -0400
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04hn2203.outbound.protection.outlook.com [52.100.163.203])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D26EE4B;
        Sun, 16 Jul 2023 12:13:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AeHDYQtHXsAUZZK3RwxGCmUCo0gU9BXWH3CM3YDOWHYyQVpY/iVBc5Mwzl4E50CVDNzuNZpGO6Pm6ZhO9qIWLma73JIUMPvwlLmLqzri5CLYoS2261MmoKFZ9RARqEsbMePJZszZS2NNxJGEMROOVnzVtaRRQoNn/RAfFQH5h5vnTn7f1sRXSuAqD0To4gxphUztc4pQiXqf04gyFyoyIWwOoXmQuzTdxlsYJ6s2BDXH0+gQo3rcY/9E7R76pgqucVckhrnvOKzfBt4gosMTA0GZ9QZFduP5jj2Kiz3lPiYjWWYCDkkC+66AWgKT5CY/c4xCsZQxdu7Yh7C5nDsCrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p/PeuBOnf5dYVxGl3ciVpz37qiwzVVT3w8y5MbyXetw=;
 b=gG8NXnq4buzgAI/iMTOB4dVa8xI5ZIo5Ea2LwID7qlWrmnv5J4+ZxdNx7eJmfGYSwgaGr5fx013WK1K1UhqJFAxdEeCBY+C5YQC3ogSGrnlozIpolAFNq34Hx0WjrfsUYfbZQAL89DzKe83qnH07DRvnMhalBDzl5A2XWZgmFL1SClbXXRKC49m2H7x11PyYYHK99JxJFFU3D2dVw1Py3nCG6x52V7xsTDdW9hNEBd3/6o6K0tg6I8DBk0DKwWG2Anh43sbPHjuKq8DS5H2sgku1J/uQchWWZ+P7tN9Et6sFEX509emPG+sW51nZv0eUbU3bqAl5GSxMTK0cNQhdUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 201.217.50.26) smtp.rcpttodomain=tmd.ac smtp.mailfrom=ips.gov.py;
 dmarc=bestguesspass action=none header.from=ips.gov.py; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ipspy.onmicrosoft.com;
 s=selector2-ipspy-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p/PeuBOnf5dYVxGl3ciVpz37qiwzVVT3w8y5MbyXetw=;
 b=1IvSiFUjqwR1B2+js2XOmQMR6Dv9Wg7W95Vppaqbwx6iH8CykOtLo6N8HF/IyEAIMiQVu6CAXCe4//cNsr1X3sEYy8D2yqKzq1gPPzC88hs6CEwEdOk7RE/zxBiBbIZQb4PPgV7JW8XZLH86b1ug0Vn5AupZ74DyFoXwREzlByk=
Received: from DS7PR03CA0357.namprd03.prod.outlook.com (2603:10b6:8:55::10) by
 CPWP152MB5370.LAMP152.PROD.OUTLOOK.COM (2603:10d6:103:175::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6588.31; Sun, 16 Jul 2023 19:13:12 +0000
Received: from DM6NAM10FT085.eop-nam10.prod.protection.outlook.com
 (2603:10b6:8:55:cafe::12) by DS7PR03CA0357.outlook.office365.com
 (2603:10b6:8:55::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.32 via Frontend
 Transport; Sun, 16 Jul 2023 19:13:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 201.217.50.26)
 smtp.mailfrom=ips.gov.py; dkim=none (message not signed)
 header.d=none;dmarc=bestguesspass action=none header.from=ips.gov.py;
Received-SPF: Pass (protection.outlook.com: domain of ips.gov.py designates
 201.217.50.26 as permitted sender) receiver=protection.outlook.com;
 client-ip=201.217.50.26; helo=mail.ips.gov.py; pr=C
Received: from mail.ips.gov.py (201.217.50.26) by
 DM6NAM10FT085.mail.protection.outlook.com (10.13.152.97) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.6588.13 via Frontend Transport; Sun, 16 Jul 2023 19:13:10 +0000
Received: from vs-w12-exch-02.ips.intranet.local (10.20.11.162) by
 vs-w12-exch-02.ips.intranet.local (10.20.11.162) with Microsoft SMTP Server
 (TLS) id 15.0.1497.42; Sun, 16 Jul 2023 15:12:32 -0400
Received: from vs-w12-exch-02.ips.intranet.local ([fe80::4132:32db:6b34:3eb2])
 by vs-w12-exch-02.ips.intranet.local ([fe80::4132:32db:6b34:3eb2%14]) with
 mapi id 15.00.1497.042; Sun, 16 Jul 2023 15:12:32 -0400
From:   Silvana Lorena Verza Petters <slverza@ips.gov.py>
To:     "t@hotmail.com" <t@hotmail.com>
Subject: !!!!!@
Thread-Topic: !!!!!@
Thread-Index: AQHZuBl4AIiFm/4VuU6e3DMORFm9fA==
Date:   Sun, 16 Jul 2023 19:12:32 +0000
Message-ID: <f546819ef1fa4c1f83fc50ff25a13bfb@vs-w12-exch-02.ips.intranet.local>
Accept-Language: es-PY, en-US
Content-Language: es-PY
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [154.6.13.18]
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM10FT085:EE_|CPWP152MB5370:EE_
X-MS-Office365-Filtering-Correlation-Id: e778bd06-bc32-4106-693e-08db8630b232
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: =?iso-8859-1?Q?8jrHifhpWaE8rBoDCMO1/NIaYvGzwJxEObASfspd2CAOr8iL3Eev8NaQU+?=
 =?iso-8859-1?Q?ZbZlbZkRbjRYkfAcMAgGaX3BMwzNWIzdoVM+33S/bX1HjeaulWxjZp3sbB?=
 =?iso-8859-1?Q?PJDWfAlII60tpYSsv6235qd4wBOiwdfbaWsfXDWZncw7VfXHdnRrb5e1yE?=
 =?iso-8859-1?Q?fVb9WhNSLecYflx1H+Iydp18E362KpOHaolZ9Pd2Ptau7gFi7Ys+AXGlmX?=
 =?iso-8859-1?Q?Wht5Xwmnw4jvl3P980KIHBsiNy21CcDIG2x59oSD+kesV9qGbbgugky85K?=
 =?iso-8859-1?Q?dq4mYT0ENYd5T5isPts3a7S6cffCMjCO7Gz8bHUnRPHJwsDZIxjhA5MMmN?=
 =?iso-8859-1?Q?jtI/4p7FWv+2x3znRL067hJDVHMAdsiYO4DQ8s29pT+JjR6Kn9KKYHD62z?=
 =?iso-8859-1?Q?DzeexrkxmeILs17ovJ3Rkb6QdrwMVXNeljo8Uk5z9JX1dpoJvzPe7DgUos?=
 =?iso-8859-1?Q?INOvheX/1wMTN5+FWT3ZZvcZXTWEenr1t9Lma42IB4CR6QJFb5k4fZG4BQ?=
 =?iso-8859-1?Q?i26QdmIySZRlfRHuTm7CwS9tZxymMsJpVpRrsx+WQzh5bpyvBXn5pTeCWK?=
 =?iso-8859-1?Q?ocu29GE+7VwsPyEIivC5BJ1ZHKdq5tWBHSWLFLPFaL7I+9Rq3F4zVNr6EW?=
 =?iso-8859-1?Q?POFpMN8GAkpDmNWdbFVWRY1nYpT4RrtKAOITHEmcVsFP29/mn/EW/3HNK+?=
 =?iso-8859-1?Q?QYvwtDh5YmrvMjBIOKvVcio70/1BbBqcOeWIWjycAC/QaJ+iP/K3NHVmgE?=
 =?iso-8859-1?Q?bStCTgRDjyajQ9ws8nAcQ5SkW6sYvHMvdcGSRp7htyeDUQ5X2VctIoh3P7?=
 =?iso-8859-1?Q?zyCJktxY3Tq8GQF6lrvZpX+XZCVNN3ZWObRL50G9RBERF15ko5UXKI4WeP?=
 =?iso-8859-1?Q?UBBmoptWv9Sk4wEwq8n7JWDz2ApvuAtN1wlDs/dbXIht4EobXLOV+p2/ON?=
 =?iso-8859-1?Q?R7eoAoHxKl7MqXzm0jfZAq+75rGZm+/W3/BNOtYIIk2AbMwPlacLBu3iJi?=
 =?iso-8859-1?Q?60SDoqxPLd9mSWTOSxRVvEjU9Ww+hwp/uX0dAaNb94231hV7FmRCvw3v9h?=
 =?iso-8859-1?Q?OLeuPtzhtake9pnFKdWpptEM0SSXhdW4BGJO1GUEEVeWmLn3dkYHLEJIm4?=
 =?iso-8859-1?Q?FNUlD226TXCANevqvIVB0pIHl1zkF4ysnCfssa/pMEyYS9zl+b4ZAbYDDn?=
 =?iso-8859-1?Q?+D81lgC2bilWPQ9zgQVACUb/0wKIUfHlMl8=3D?=
X-Forefront-Antispam-Report: CIP:201.217.50.26;CTRY:PY;LANG:en;SCL:5;SRV:;IPV:NLI;SFV:SPM;H:mail.ips.gov.py;PTR:mail.ips.gov.py;CAT:OSPM;SFS:(13230028)(396003)(376002)(346002)(39860400002)(136003)(451199021)(82310400008)(36840700001)(40480700001)(55016003)(9686003)(567454004)(108616005)(7696005)(24736004)(70586007)(70206006)(478600001)(82740400003)(356005)(7596003)(83380400001)(336012)(186003)(32650700002)(26005)(36860700001)(86362001)(558084003)(6862004)(2906002)(5660300002)(8676002)(8936002)(7416002)(7406005)(7366002)(7336002)(41300700001)(316002)(16050700002);DIR:OUT;SFP:1501;
X-OriginatorOrg: ips.gov.py
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2023 19:13:10.3789
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e778bd06-bc32-4106-693e-08db8630b232
X-MS-Exchange-CrossTenant-Id: 601d630b-0433-4b64-9f43-f0b9b1dcab7f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=601d630b-0433-4b64-9f43-f0b9b1dcab7f;Ip=[201.217.50.26];Helo=[mail.ips.gov.py]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM10FT085.eop-nam10.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CPWP152MB5370
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

=0A=
=0A=
I have an urgent communication with you Contact me privately.=0A=
=0A=
E-mail: rccrc00@gmail.com=0A=
=0A=
for details.=0A=
