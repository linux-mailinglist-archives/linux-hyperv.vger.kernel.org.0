Return-Path: <linux-hyperv+bounces-1-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F042F79249C
	for <lists+linux-hyperv@lfdr.de>; Tue,  5 Sep 2023 17:59:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A421A28124A
	for <lists+linux-hyperv@lfdr.de>; Tue,  5 Sep 2023 15:59:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8FA3D53A;
	Tue,  5 Sep 2023 15:59:34 +0000 (UTC)
X-Original-To: linux-hyperv@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB7FACA57
	for <linux-hyperv@vger.kernel.org>; Tue,  5 Sep 2023 15:59:34 +0000 (UTC)
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com [IPv6:2607:f8b0:4864:20::832])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 161ED1BE7
	for <linux-hyperv@vger.kernel.org>; Tue,  5 Sep 2023 08:59:08 -0700 (PDT)
Received: by mail-qt1-x832.google.com with SMTP id d75a77b69052e-412137ae07aso15703501cf.2
        for <linux-hyperv@vger.kernel.org>; Tue, 05 Sep 2023 08:59:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1693929532; x=1694534332; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ErM/Mb+jvgC6R97N5RcSJIPEwelf/VZ957FPCYzkM0w=;
        b=HvlpyrrfavXeiGR92EmUKAMeHCqV66sTFRs2LaScAETjAWPgoqJxnghq943urOKuEM
         +xqbq7J3bzQg9vZIBKhE7g9mx1UnMTDG1LE3kCnNlHUgcJCG8AawgCHRjK1Y1CV/xX/2
         K/qa6fzpHW4Wmv94t3H0ulKsgyLeWAYYUZQXc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693929532; x=1694534332;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ErM/Mb+jvgC6R97N5RcSJIPEwelf/VZ957FPCYzkM0w=;
        b=Osf8MLbwyVxpX2odE1kKf7DISD03Z07REvBBc3Ll6R6LPCoEJEVfO1MpdagtyxG1pf
         Frc8uDPsPPHsVHz+AQvdEIQd9S4sf8Ii6kPvfIUHL9RjVPaX1P4FkBZk5zeJo+o+PoL3
         efmPvpmOtmjicZXNCu7ZFa0DXcmfDRmmvg+45s8vi4pWDQTAJacNg/eYHoEPtx/nafGm
         lFpw7/y6vLvwm9JfXkl8RlAPY/F8AaAoTor3OjOIEoS9b6SD/u7Y+6BdFDLyqSux9ue7
         XM3KRuAh2Ij3GdfoBCcKWs43+1JagEXSG6iRExTMUh7JqcdudHQn8lkP02EVN8cjoG0m
         QCxg==
X-Gm-Message-State: AOJu0YyFqWyZm26l8NDrJpqupP/dQDZdLa4R+Sdxddp4NkaLwsBrXCpK
	XXdBXoChoHy5CDI2w1fvwZTw5avgKSNp1OckF2w=
X-Google-Smtp-Source: AGHT+IGo/2k7aJcOetgZ7JBJVFzj8NdFt4rdf3t6ZrmHc+fIK1Jadc5ayjOlW3YVqNUAvIFkm50HjQ==
X-Received: by 2002:ac8:5dd2:0:b0:405:464d:5bb0 with SMTP id e18-20020ac85dd2000000b00405464d5bb0mr15531700qtx.32.1693929532445;
        Tue, 05 Sep 2023 08:58:52 -0700 (PDT)
Received: from meerkat.local ([209.226.106.110])
        by smtp.gmail.com with ESMTPSA id h16-20020ac846d0000000b0040ff387de83sm4468773qto.45.2023.09.05.08.58.52
        for <linux-hyperv@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Sep 2023 08:58:52 -0700 (PDT)
Date: Tue, 5 Sep 2023 11:58:43 -0400
From: Konstantin Ryabitsev <konstantin@linuxfoundation.org>
To: linux-hyperv@vger.kernel.org
Subject: This list has been migrated to the new infrastructure
Message-ID: <20230905-mortally-gap-190ba0@meerkat>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hello:

The linux-hyperv list has been migrated to the new vger infrastructure. This
should be a fully transparent process and you don't need to change anything
about how you participate with the list or how you receive mail.

This message acts as a final test to make sure that the list archives are
properly updating.

Best regards,
Konstantin

