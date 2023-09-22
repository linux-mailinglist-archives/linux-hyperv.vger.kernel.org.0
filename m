Return-Path: <linux-hyperv+bounces-196-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 698257AB997
	for <lists+linux-hyperv@lfdr.de>; Fri, 22 Sep 2023 20:49:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sy.mirrors.kernel.org (Postfix) with ESMTP id 9B969B209CA
	for <lists+linux-hyperv@lfdr.de>; Fri, 22 Sep 2023 18:49:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CC0343A80;
	Fri, 22 Sep 2023 18:49:02 +0000 (UTC)
X-Original-To: linux-hyperv@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 110F742BFB
	for <linux-hyperv@vger.kernel.org>; Fri, 22 Sep 2023 18:49:00 +0000 (UTC)
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C52FB7;
	Fri, 22 Sep 2023 11:48:58 -0700 (PDT)
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-68cbbff84f6so2925173b3a.1;
        Fri, 22 Sep 2023 11:48:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695408538; x=1696013338;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hL5bEyIdwLqLeBmJpTNF22yRvuv3aGh3Q9CwJkae028=;
        b=cfqbslfLC7cRfJNvdd5xYsFSc9LDayjcTlHdDlhKRwFL2fE8LUJL7lSVxag19jYlJ4
         SdnFMtMUAKtuEc/drAqxk9ZCq7PGe5u41QMKweifiJTxJlAgYvMC2tZzgCRMsdKPHPJs
         6nqxiR0e3g2J0ofr6x7flTB8pynBUXondIuoZtHlbedMvjXxq69dzS7wCbW4Jg6LNaAZ
         eDKmespwnnYYKPPzit/scIx8fR6y25XUxsiQAWL20c0m1HNfD0BcQFBvuR0kHUr9MW/e
         gDvrfY8PTOkMsFNK/h9UoEIp7KDRKv3bREh964xhE7oTfciqTiEauYpV55XKCqSrAsoY
         YENg==
X-Gm-Message-State: AOJu0YxZh2uLBddPRq2hGZoveI/eJ81APf0wXTGXJEOgDj5MYqd5CE5n
	L+qjScmc17R89AC81GV0Bpg=
X-Google-Smtp-Source: AGHT+IHH3V+wn81SPydKnVucq6fioEnuRLf9tOh/vQim6/QBf0odXijPI8phhlNSwrYfPzOStF+8kA==
X-Received: by 2002:a05:6a21:7891:b0:152:4615:cb9e with SMTP id bf17-20020a056a21789100b001524615cb9emr696294pzc.13.1695408537936;
        Fri, 22 Sep 2023 11:48:57 -0700 (PDT)
Received: from liuwe-devbox-debian-v2 ([20.69.120.36])
        by smtp.gmail.com with ESMTPSA id q17-20020a637511000000b00570574feda0sm3473414pgc.19.2023.09.22.11.48.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Sep 2023 11:48:57 -0700 (PDT)
Date: Fri, 22 Sep 2023 18:48:14 +0000
From: Wei Liu <wei.liu@kernel.org>
To: Nuno Das Neves <nunodasneves@linux.microsoft.com>
Cc: linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
	x86@kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-arch@vger.kernel.org, patches@lists.linux.dev,
	mikelley@microsoft.com, kys@microsoft.com, wei.liu@kernel.org,
	gregkh@linuxfoundation.org, haiyangz@microsoft.com,
	decui@microsoft.com, apais@linux.microsoft.com,
	Tianyu.Lan@microsoft.com, ssengar@linux.microsoft.com,
	mukeshrathor@microsoft.com, stanislav.kinsburskiy@gmail.com,
	jinankjain@linux.microsoft.com, vkuznets@redhat.com,
	tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
	dave.hansen@linux.intel.com, hpa@zytor.com, will@kernel.org,
	catalin.marinas@arm.com
Subject: Re: [PATCH v3 12/15] Documentation: Reserve ioctl number for mshv
 driver
Message-ID: <ZQ3hbhOJdjbveIUH@liuwe-devbox-debian-v2>
References: <1695407915-12216-1-git-send-email-nunodasneves@linux.microsoft.com>
 <1695407915-12216-13-git-send-email-nunodasneves@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1695407915-12216-13-git-send-email-nunodasneves@linux.microsoft.com>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Fri, Sep 22, 2023 at 11:38:32AM -0700, Nuno Das Neves wrote:
> Signed-off-by: Nuno Das Neves <nunodasneves@linux.microsoft.com>
> Acked-by: Jonathan Corbet <corbet@lwn.net>

Acked-by: Wei Liu <wei.liu@kernel.org>

