Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C98E177992D
	for <lists+linux-hyperv@lfdr.de>; Fri, 11 Aug 2023 23:07:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235522AbjHKVH1 (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 11 Aug 2023 17:07:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231649AbjHKVH1 (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 11 Aug 2023 17:07:27 -0400
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBB7DAC;
        Fri, 11 Aug 2023 14:07:26 -0700 (PDT)
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-6877eb31261so1808770b3a.1;
        Fri, 11 Aug 2023 14:07:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691788046; x=1692392846;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=puTbY/O3o1VnyDIFyQ3hoBMgIj6VV4jgvGrLai62MEU=;
        b=X63zzXSPUBhYtEiP67CepjJ7szvTFc9HEWIRlBBzFigePHaELkAdW62UybvX8CRcYl
         mIb621e6Jm1e7Qf9EbjJxu97O2rqgDuqLCuLLLtraoylBTD6o6fr5o61p5WK0cQ9Qm29
         Wo3XnshFyvD4pjRXmB3/AJN3934RT321zinTCiGn/T+VrfaThVYAW/g3x4cPiDbEh9Aj
         5SicNtj2oexD6ZMcDVLzOo3UeGSfvlSYTeL6D7Hv6kpjc3IJNteZCZg1Pt/did4ZV2qF
         ed9+twkl0fbBceZ96yTjnqLFYz3fi2O8VT6iqUHI++eMtrK3sALbCXV/uMGaisbcsk2u
         G7FQ==
X-Gm-Message-State: AOJu0YwTBjTGbuKz+OpSH+3XbXxK8PpjYz7zBhsomfj1kZ+qFobL009x
        jimitN5opV9LfoTWH1Ny6JFP1ZVEUvM=
X-Google-Smtp-Source: AGHT+IEBRTGMh5o9h0WlTkntMmf61f5Z6UUzoo4YDfGRG5F9kNrve7qDl1k4COvNv4RsuYIMBA3h6w==
X-Received: by 2002:a05:6a21:9994:b0:130:7803:5843 with SMTP id ve20-20020a056a21999400b0013078035843mr3575162pzb.4.1691788046230;
        Fri, 11 Aug 2023 14:07:26 -0700 (PDT)
Received: from liuwe-devbox-debian-v2 ([20.69.120.36])
        by smtp.gmail.com with ESMTPSA id ey6-20020a056a0038c600b006870ed427b2sm3846795pfb.94.2023.08.11.14.07.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Aug 2023 14:07:25 -0700 (PDT)
Date:   Fri, 11 Aug 2023 21:07:12 +0000
From:   Wei Liu <wei.liu@kernel.org>
To:     levymitchell0@gmail.com
Cc:     "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
        linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
        mikelley@microsoft.com, peterz@infradead.org,
        Boqun Feng <boqun.feng@gmail.com>
Subject: Re: [PATCH v2] hv_balloon: Update the balloon driver to use the SBRM
 API
Message-ID: <ZNajAHD7KLfwR140@liuwe-devbox-debian-v2>
References: <20230807-sbrm-hyperv-v2-1-9d2ac15305bd@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230807-sbrm-hyperv-v2-1-9d2ac15305bd@gmail.com>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Mon, Aug 07, 2023 at 11:55:47PM +0000, Mitchell Levy via B4 Relay wrote:
> From: Mitchell Levy <levymitchell0@gmail.com>
> 
> This patch is intended as a proof-of-concept for the new SBRM
> machinery[1]. For some brief background, the idea behind SBRM is using
> the __cleanup__ attribute to automatically unlock locks (or otherwise
> release resources) when they go out of scope, similar to C++ style RAII.
> This promises some benefits such as making code simpler (particularly
> where you have lots of goto fail; type constructs) as well as reducing
> the surface area for certain kinds of bugs.
> 
> The changes in this patch should not result in any difference in how the
> code actually runs (i.e., it's purely an exercise in this new syntax
> sugar). In one instance SBRM was not appropriate, so I left that part
> alone, but all other locking/unlocking is handled automatically in this
> patch.
> 
> [1] https://lore.kernel.org/all/20230626125726.GU4253@hirez.programming.kicks-ass.net/
> 
> Suggested-by: Boqun Feng <boqun.feng@gmail.com>
> Signed-off-by: "Mitchell Levy (Microsoft)" <levymitchell0@gmail.com>
> Reviewed-by: Boqun Feng <boqun.feng@gmail.com>

Applied to hyperv-next. Thanks!
