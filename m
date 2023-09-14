Return-Path: <linux-hyperv+bounces-77-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 712A07A0AFC
	for <lists+linux-hyperv@lfdr.de>; Thu, 14 Sep 2023 18:45:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 19B441C20869
	for <lists+linux-hyperv@lfdr.de>; Thu, 14 Sep 2023 16:45:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC4081CFB8;
	Thu, 14 Sep 2023 16:45:25 +0000 (UTC)
X-Original-To: linux-hyperv@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1F68C8F3
	for <linux-hyperv@vger.kernel.org>; Thu, 14 Sep 2023 16:45:25 +0000 (UTC)
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38CC01FDC
	for <linux-hyperv@vger.kernel.org>; Thu, 14 Sep 2023 09:45:25 -0700 (PDT)
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-54290603887so888261a12.1
        for <linux-hyperv@vger.kernel.org>; Thu, 14 Sep 2023 09:45:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694709924; x=1695314724;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Sd+i/dsqDqXlUNMV2SCPLk9f0K5zcCjoQJ50UAQIR2U=;
        b=sny7UqWOJyrjRvl3ALQ5zctv0sjnHzzb+4/3FSv2GetKWOa7y8LXm2B8So34kewNtL
         CjDprRSxQG0AWIhaEL28jzK0pwZUXYjRHWKKlD++qWFs4l0kPDy+UUOrERzBzqRlpXQF
         tGeUFww0LR4tL/TCg4r9nbAHG9qCK1sOSR5N1hI3bOV/z6GYQEySSeUgwRYMaG043Zsp
         NW9Ed2pJp4pqX5dCoXBT+NiGqlxL693ieS2rAuz9eKvX5X5FCuG9sCfh3OXrt+XaqHYE
         Nlj5vH1EnjAL5Ads2SzPXGp+3E+xBN3GcSgdc7dIByfyY2DCV3xNhn/i0KCQ4IB3hDoL
         BNAg==
X-Gm-Message-State: AOJu0Yw5j0iiweTxPN32UWfVm8xzNIXDqpkpCJjR1NePnUnKit1pNFPi
	Hr4d09q/pKbtiFrogCQwQVY=
X-Google-Smtp-Source: AGHT+IFT+alj8/51ItNOg5APyupqqJulO7t8Ge08UX0PlY64a6Mt67aOlFn8zNlfdO3poCWGtmGf2A==
X-Received: by 2002:a17:90b:4b48:b0:274:3d7d:e793 with SMTP id mi8-20020a17090b4b4800b002743d7de793mr5911042pjb.47.1694709924494;
        Thu, 14 Sep 2023 09:45:24 -0700 (PDT)
Received: from liuwe-devbox-debian-v2 ([20.69.120.36])
        by smtp.gmail.com with ESMTPSA id np10-20020a17090b4c4a00b0026b6b17ca5dsm1557247pjb.54.2023.09.14.09.45.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Sep 2023 09:45:23 -0700 (PDT)
Date: Thu, 14 Sep 2023 16:44:47 +0000
From: Wei Liu <wei.liu@kernel.org>
To: Konstantin Ryabitsev <konstantin@linuxfoundation.org>
Cc: linux-hyperv@vger.kernel.org, Wei Liu <wei.liu@kernel.org>
Subject: Re: This list has been migrated to the new infrastructure
Message-ID: <ZQM4f/i9vu5z22Iz@liuwe-devbox-debian-v2>
References: <20230905-mortally-gap-190ba0@meerkat>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230905-mortally-gap-190ba0@meerkat>

On Tue, Sep 05, 2023 at 11:58:43AM -0400, Konstantin Ryabitsev wrote:
> Hello:
> 
> The linux-hyperv list has been migrated to the new vger infrastructure. This
> should be a fully transparent process and you don't need to change anything
> about how you participate with the list or how you receive mail.
> 
> This message acts as a final test to make sure that the list archives are
> properly updating.

Thank you very much!

Wei.

