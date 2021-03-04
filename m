Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B557F32CB34
	for <lists+linux-hyperv@lfdr.de>; Thu,  4 Mar 2021 05:11:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230386AbhCDEKs (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 3 Mar 2021 23:10:48 -0500
Received: from aserp2130.oracle.com ([141.146.126.79]:50584 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233289AbhCDEKq (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 3 Mar 2021 23:10:46 -0500
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 124403lJ002810;
        Thu, 4 Mar 2021 04:09:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : message-id : references : date : in-reply-to : content-type :
 mime-version; s=corp-2020-01-29;
 bh=PeYtYNYkWp4/WhChpj3EsP8629iRKUxeZKxVSJ9IsEo=;
 b=j0CbyrNlOwrT785OhLZOwHgHgKUgJSHCXVXYJM6JV5NmATlbztDp8GRRC12X22vlHyqv
 2SiAJp7vzatqQ7O+ltpIQq+T15kLkKIXp8sB+OoRB2BF86LUX56mDke7PLRQOM3LJB5w
 69+ZWbnYvKg0ZILkZy/jeo2ZGA+R0FVmexpSzAZsF5E/1RlX3CXRsD5Av0WqLP2QsVaj
 ccmKuDDZ5C7KT/1wQYZZI67P/lBDI+dTDcDup81cwNffVCAI7Yt9YMRpKKeHQda6+2nf
 4LFs9W802IRQz5FnfYWpfNRDM7D2GP1/OSxJ8vS4MRFHddQcwL8odcXbGQivAHoXyvad CA== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2130.oracle.com with ESMTP id 36ybkbdthb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 04 Mar 2021 04:09:57 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 1243t5Uf150777;
        Thu, 4 Mar 2021 04:09:57 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2172.outbound.protection.outlook.com [104.47.59.172])
        by aserp3030.oracle.com with ESMTP id 36yynrckg0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 04 Mar 2021 04:09:57 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B2TYhALkAmoocGC6M+Ol/mJhkn+ikDrF3eC4VdwlNOR/Pst6GS9/HxhGud6mNvdKiibdsuH2PboypGu77DC5W1YcIr6qluh3elcOGf8BilULVijxyQBFMSy+nRUeRP5iDehU4iZ8WKoZj9XBwT90Gjc0lBmSa+jcbbDnKBHx6qqncSfgOyvLTE5OOVSpp+oxn/jOSLp5TB82Uy1SLYLRHC9ln2bInCuGr8y5+nNqSRevDAxWY2cwMs95zRmXPVD0HL115HKYbO1Ldi+762g10nF0Z/AZgJc5lW+LMj/6HEWuxAkmr+PucauE6KZE4rrpFm9PfPs5qsMSNoNqZu+QNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PeYtYNYkWp4/WhChpj3EsP8629iRKUxeZKxVSJ9IsEo=;
 b=Jdoi04UgqtELhnNPH7dyCP62xhC0opK9Ud0LUeozjF44yt/PyQ9Bl0gBlfUWjprEBZcCEd6TVvYOqfGglhKDmtJRwi6KwkIHcxlp36Omjy11RcPfCl+bOuGaarKbhBQU2GxLXxa5hQlgiKUgomCwxLWw03zEQLOLVdfXmLITfCVVCjv79od3VeHhhXekEkUS5lJ+BRQi6BEjDGNv4eH8Lng2Fv/9IUUtcA6HQXWH+MgOjYrYTeWYk5ofL3uw7EX0t6XrLBqvHZHfWheuNU3rVzye9xLMnzaDbNiXQZl4neD09W67wq6Ocku5//pi+ecYPPgABI6qQaiRtyKEQU2YUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PeYtYNYkWp4/WhChpj3EsP8629iRKUxeZKxVSJ9IsEo=;
 b=q8pSYWFcoX1QcWuioGm46WMa+OPPTn2fzkSu9kCe7tHkNles9kJMU9oM6ReoUMcMYpUqWJBwcEuNMx2essSMVjtC+eZ/WdYuwX/8LoFfttSLNfBhpkfH9bneRi79vZfFvUr8XtxHffGFw9tFq8dIZuov+iTIZeiNiYSwGmXdFf4=
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=oracle.com;
Received: from PH0PR10MB4759.namprd10.prod.outlook.com (2603:10b6:510:3d::12)
 by PH0PR10MB4791.namprd10.prod.outlook.com (2603:10b6:510:3a::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3868.27; Thu, 4 Mar
 2021 04:09:54 +0000
Received: from PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::dc39:c9fa:7365:8c8e]) by PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::dc39:c9fa:7365:8c8e%5]) with mapi id 15.20.3912.018; Thu, 4 Mar 2021
 04:09:54 +0000
To:     "Melanie Plageman (Microsoft)" <melanieplageman@gmail.com>
Cc:     linux-scsi@vger.kernel.org, andres@anarazel.de,
        haiyangz@microsoft.com, jejb@linux.ibm.com, kys@microsoft.com,
        linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
        martin.petersen@oracle.com, mikelley@microsoft.com,
        sthemmin@microsoft.com, wei.liu@kernel.org
Subject: Re: [PATCH v4] scsi: storvsc: Parameterize number hardware queues
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
Message-ID: <yq1blbzh856.fsf@ca-mkp.ca.oracle.com>
References: <20210224232948.4651-1-melanieplageman@gmail.com>
Date:   Wed, 03 Mar 2021 23:09:52 -0500
In-Reply-To: <20210224232948.4651-1-melanieplageman@gmail.com> (Melanie
        Plageman's message of "Wed, 24 Feb 2021 23:29:48 +0000")
Content-Type: text/plain
X-Originating-IP: [138.3.200.58]
X-ClientProxiedBy: SJ0PR03CA0086.namprd03.prod.outlook.com
 (2603:10b6:a03:331::31) To PH0PR10MB4759.namprd10.prod.outlook.com
 (2603:10b6:510:3d::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from ca-mkp.ca.oracle.com (138.3.200.58) by SJ0PR03CA0086.namprd03.prod.outlook.com (2603:10b6:a03:331::31) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.17 via Frontend Transport; Thu, 4 Mar 2021 04:09:54 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 57bc5805-2747-4a6a-06aa-08d8dec35daf
X-MS-TrafficTypeDiagnostic: PH0PR10MB4791:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <PH0PR10MB4791FC9567643EBABC0A70A48E979@PH0PR10MB4791.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EbhdVZxc23B5rMq6bF+LsM+w1mpIutNhV2V+n2WBPQ5nGVxvQeGIAyMtKeKQlLuU9lOLdEILdgi9yaw2gQuo3cO8ddb3aY0+Ag09RIKrT6/YH8U5w8i9kQyiSMpAkeaD8cuscTcfR8v2CqflSMwyYIAfw/vJ78JqCgaLaz8bZCqQCWjwrHz/KwRu+5C6k44b5hk5n+6+kbZGrI4Z0pTZBOzU/6HoaJWRtWlitHkw55L9ehoWO1jgP02qsA8fMFKYc8ZWpy4+fzY+l8WX+xX6F4e8Eh7dlLnh6DNDyb0fnSnODavp8nEYaPvVnA5Ltm1eznqtBeL8CsVY88hKdNHsmevgHtJ4JaF+jGnL63hC4p7fcU8YMUBOBXflVLXCUY9Urfnf9vrus8TbB8hUUqECTelHom3TdJIi0eUP5HEgkqn1WU597VJ8LExlu5O0f6Phl8LmFDVw6fcj4e2kl7ylLbiXOWtmVqlOEtqADKX15LY//fpXcpSmxgObwyd6Nt6Tlh05AnSn1l3Li8Qz0k6Otg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB4759.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(396003)(346002)(136003)(39860400002)(376002)(86362001)(66556008)(66476007)(8676002)(66946007)(186003)(45080400002)(5660300002)(16526019)(7696005)(52116002)(55016002)(8936002)(316002)(36916002)(7416002)(4326008)(6916009)(956004)(2906002)(478600001)(26005)(4744005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?HdmFbHryyE0TuAPQnNVZio5nkde3D6gJslTmTaXBLUn6zg5Xi8ke91lqZwM4?=
 =?us-ascii?Q?ZCuIho5l7pRX14JIkf3HM+y8agLnFyrILoslzUMXecvWmOgAb9aS3a/PU057?=
 =?us-ascii?Q?9LYZukcR4p9T/UdxremEw9vo12UOLq4g4+JEfja//JDrkuvFH3QEMs645ZPr?=
 =?us-ascii?Q?KPk27dBohg6rnc5rKzkmiHlaW0uLrhP2kmbMIe2vpiCguNH8JPpgKJcaziUN?=
 =?us-ascii?Q?z7vOHTgxwwf6jpXXxDSrRDnQZ9JY6zl+FVM+J7LE5NxaeBtNFkZHafnScxuP?=
 =?us-ascii?Q?TwYXVertZR3sVvGXkcfrC7U69zpl3tT/a4zv/dduYR2RDhg0JZnNYsG2VkLC?=
 =?us-ascii?Q?DrwTbAKksTfG5VwOq3BIv6rZ2jtU2lPFzU6iJL3/y+lXZCARni+ZWYsUnD40?=
 =?us-ascii?Q?leBVnUQKVAEos/+NZzPe4Z/g91eD3j4Mi7QfFVG0DMfwXVrg3jxKvZ+s9Qe9?=
 =?us-ascii?Q?jZ+b55rBUeF4QlkqWu360WRhR2DJ4eJao4oP60g7YOFON++0YFWW49+ULyUX?=
 =?us-ascii?Q?RsYlButFlgucFTExsMWEFHGbhn6ZHmkg47hDtqeSopUE9cF95nMVSTHk9hRF?=
 =?us-ascii?Q?v9qwebTNBUcLrj9V04+985opzSijOWLwLblssU0jFtsJpuJV1ahazZyMBY2d?=
 =?us-ascii?Q?k1cqcwvMdNDPjqejvavaVir3gJaUxiqQsDqPYDML42/GioV2/AHIQrvfgVoU?=
 =?us-ascii?Q?HZ5UvuJIdUhB2R1kiZho9+Wn7In9ZrJ/EbKvOyqRJSMmSfQcXZjDZn3nw1Yi?=
 =?us-ascii?Q?Ial9w8oo9nR2RNJ9WyRkWTqoK8l2VhVBq1SrqRjYpQl4WFgZ3Fu7lvhtFWYz?=
 =?us-ascii?Q?eNcSDRMQYLyAFoRoMRdgRICRk7GdplUQCbHR98KPAgIXsCsh7JEXwiD1Dydj?=
 =?us-ascii?Q?Iyt4Gdzq0lkLKKKILfrFZ1A5Hhr3xTENI0GpWMhz0RZlMHKOWakp9DycghV9?=
 =?us-ascii?Q?+B5pOj6tbDDB1UJoURGfi5e3NsXeiUkIeKKHpmaeIsFCBq2yiurIhlVmnkHf?=
 =?us-ascii?Q?k87PMay/3Fi+zoDwpIvFugFyvUxY/7q/AcQi0l3VH2OaAWuz/uwMnYpY5a0B?=
 =?us-ascii?Q?hC8N7le/Op37fei+69z6w3l4BZcBjhhPc5DEX3p6uTd8CYeUwU7EU6jp/M7L?=
 =?us-ascii?Q?VjMJK0jqHcSycM6rqf9vSlbA8PIZUCSUE0v6jXwn5nG8gc4QGuJTKmgtBj57?=
 =?us-ascii?Q?43YGg2cLiRM2UKIq9TohNCfmcGU4RF9goR10fxLuzzWbnqW8Eo/MawVRZhD5?=
 =?us-ascii?Q?ucFu3DOTYllpclt+N7zK4V2XKN0KYGV3Df+KQnz6WfaVLfq+0mQzhv09DUOB?=
 =?us-ascii?Q?o6dqx6G8XmLse+xmezypsLcR?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 57bc5805-2747-4a6a-06aa-08d8dec35daf
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB4759.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2021 04:09:54.6159
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +agITHa2Z7NkIn/rrueI/asEXBlkswLO2APfbPuhbiPVJM/PPRGGMMOFlYGU+cgULvFzjISIiXflMRKeQKobZUstfloDTtQ/SSQtbCJ9MVw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4791
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9912 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxscore=0 spamscore=0
 bulkscore=0 suspectscore=0 mlxlogscore=959 phishscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2103040014
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9912 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 impostorscore=0
 suspectscore=0 phishscore=0 bulkscore=0 mlxscore=0 lowpriorityscore=0
 clxscore=1011 mlxlogscore=999 adultscore=0 malwarescore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2103040014
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org


Melanie,

> Add ability to set the number of hardware queues with new module
> parameter, storvsc_max_hw_queues. The default value remains the number
> of CPUs.  This functionality is useful in some environments
> (e.g. Microsoft Azure) where decreasing the number of hardware queues
> has been shown to improve performance.

Applied to 5.13/scsi-staging, thanks!

-- 
Martin K. Petersen	Oracle Linux Engineering
