Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79BDC75111A
	for <lists+linux-hyperv@lfdr.de>; Wed, 12 Jul 2023 21:24:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232512AbjGLTYF (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 12 Jul 2023 15:24:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229775AbjGLTYD (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 12 Jul 2023 15:24:03 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B7681FC2;
        Wed, 12 Jul 2023 12:24:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0A0D2618F9;
        Wed, 12 Jul 2023 19:24:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2E67C433C7;
        Wed, 12 Jul 2023 19:22:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689189841;
        bh=Tfejh8EXB17kdCnKChHCKsENFyCAyHmgokGK8jgx0S4=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=ntLZbbIa8ui4VLewT/ZWNtkWgRs7MbRiBOhFPmK6XwjRbTD/3kPBu1aqhFZ0rkrTw
         NoTZi0Izio/rxjoLWBubaj+3vL5lvYukHPTwqzZkAMQJcVh8+LeSyVQRiF6uaWPcM/
         zuqSfu4Q9tdtMALob+iDjB+wXeO+wx4IclmprAMk1ovBvhz2Kb6mUBbsrON4ASXRiy
         LcrKecm8vPG1UI+nVF2Hnnsm4BKqA7ElLyIZzw3R6g6ih439+oVUcyzCdQwNklbbMO
         NQNR0TgJUV9FeYvO7UXNbntxcy7XKI2L5F9S7YJV8onDbx66b25wYy9gLnXBEh/586
         QVl33fuhfdZNQ==
Message-ID: <2eeb1271-731a-1a70-4c83-449567452f8f@kernel.org>
Date:   Wed, 12 Jul 2023 21:22:44 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [Freedreno] [PATCH RFC v1 00/52] drm/crtc: Rename struct
 drm_crtc::dev to drm_dev
Content-Language: en-US
To:     Sean Paul <seanpaul@chromium.org>,
        Jani Nikula <jani.nikula@intel.com>
Cc:     =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>,
        Harry Wentland <harry.wentland@amd.com>,
        Leo Li <sunpeng.li@amd.com>,
        Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
        Hamza Mahfooz <hamza.mahfooz@amd.com>,
        Javier Martinez Canillas <javierm@redhat.com>,
        Guchun Chen <guchun.chen@amd.com>,
        Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
        Evan Quan <evan.quan@amd.com>, Likun Gao <Likun.Gao@amd.com>,
        =?UTF-8?B?TWFyZWsgT2zFocOhaw==?= <marek.olsak@amd.com>,
        David Francis <David.Francis@amd.com>,
        Hawking Zhang <Hawking.Zhang@amd.com>,
        Graham Sider <Graham.Sider@amd.com>, Lang Yu <Lang.Yu@amd.com>,
        Philip Yang <Philip.Yang@amd.com>,
        Yifan Zhang <yifan1.zhang@amd.com>,
        Tim Huang <Tim.Huang@amd.com>, Zack Rusin <zackr@vmware.com>,
        Sam Ravnborg <sam@ravnborg.org>, xurui <xurui@kylinos.cn>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        =?UTF-8?Q?Ma=c3=adra_Canal?= <mairacanal@riseup.net>,
        =?UTF-8?Q?Andr=c3=a9_Almeida?= <andrealmeid@igalia.com>,
        Qingqing Zhuo <qingqing.zhuo@amd.com>,
        Aurabindo Pillai <aurabindo.pillai@amd.com>,
        Hersen Wu <hersenxs.wu@amd.com>,
        Fangzhi Zuo <jerry.zuo@amd.com>,
        Stylon Wang <stylon.wang@amd.com>,
        Alan Liu <haoping.liu@amd.com>, Wayne Lin <Wayne.Lin@amd.com>,
        Aaron Liu <aaron.liu@amd.com>, Melissa Wen <mwen@igalia.com>,
        Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>,
        David Tadokoro <davidbtadokoro@usp.br>,
        Wenjing Liu <wenjing.liu@amd.com>,
        Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
        Mario Limonciello <mario.limonciello@amd.com>,
        Alexey Kodanev <aleksei.kodanev@bell-sw.com>,
        Roman Li <roman.li@amd.com>,
        =?UTF-8?Q?Joaqu=c3=adn_Ignacio_Aramend=c3=ada?= 
        <samsagax@gmail.com>, Dave Airlie <airlied@redhat.com>,
        Russell King <linux@armlinux.org.uk>,
        Liviu Dudau <liviu.dudau@arm.com>,
        Joel Stanley <joel@jms.id.au>,
        Boris Brezillon <bbrezillon@kernel.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        Inki Dae <inki.dae@samsung.com>,
        Seung-Woo Kim <sw0312.kim@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Stefan Agner <stefan@agner.ch>,
        Alison Wang <alison.wang@nxp.com>,
        Patrik Jakobsson <patrik.r.jakobsson@gmail.com>,
        =?UTF-8?Q?Noralf_Tr=c3=b8nnes?= <noralf@tronnes.org>,
        Xinliang Liu <xinliang.liu@linaro.org>,
        Tian Tao <tiantao6@hisilicon.com>,
        Danilo Krummrich <dakr@redhat.com>,
        Deepak Rawat <drawat.floss@gmail.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        =?UTF-8?B?VmlsbGUgU3lyasOkbMOk?= <ville.syrjala@linux.intel.com>,
        Lucas De Marchi <lucas.demarchi@intel.com>,
        Ankit Nautiyal <ankit.k.nautiyal@intel.com>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        Matt Roper <matthew.d.roper@intel.com>,
        Stanislav Lisovskiy <stanislav.lisovskiy@intel.com>,
        Radhakrishna Sripada <radhakrishna.sripada@intel.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Luca Coelho <luciano.coelho@intel.com>,
        Niranjana Vishwanathapura <niranjana.vishwanathapura@intel.com>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        Vinod Govindapillai <vinod.govindapillai@intel.com>,
        =?UTF-8?Q?=c5=81ukasz_Bartosik?= <lb@semihalf.com>,
        Anusha Srivatsa <anusha.srivatsa@intel.com>,
        Chaitanya Kumar Borah <chaitanya.kumar.borah@intel.com>,
        Uma Shankar <uma.shankar@intel.com>,
        Imre Deak <imre.deak@intel.com>,
        Mitul Golani <mitulkumar.ajitkumar.golani@intel.com>,
        Swati Sharma <swati2.sharma@intel.com>,
        =?UTF-8?Q?Jouni_H=c3=b6gander?= <jouni.hogander@intel.com>,
        Mika Kahola <mika.kahola@intel.com>,
        =?UTF-8?Q?Jos=c3=a9_Roberto_de_Souza?= <jose.souza@intel.com>,
        Arun R Murthy <arun.r.murthy@intel.com>,
        Gustavo Sousa <gustavo.sousa@intel.com>,
        Khaled Almahallawy <khaled.almahallawy@intel.com>,
        Juha-Pekka Heikkila <juhapekka.heikkila@gmail.com>,
        Andi Shyti <andi.shyti@linux.intel.com>,
        Nirmoy Das <nirmoy.das@intel.com>,
        Fei Yang <fei.yang@intel.com>,
        Animesh Manna <animesh.manna@intel.com>,
        Deepak R Varma <drv@mailo.com>,
        "Jiri Slaby (SUSE)" <jirislaby@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Vandita Kulkarni <vandita.kulkarni@intel.com>,
        Suraj Kandpal <suraj.kandpal@intel.com>,
        Manasi Navare <manasi.d.navare@intel.com>,
        Drew Davenport <ddavenport@chromium.org>,
        Laurentiu Palcu <laurentiu.palcu@oss.nxp.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Marian Cichy <m.cichy@pengutronix.de>,
        Dan Carpenter <error27@gmail.com>,
        Paul Cercueil <paul@crapouillou.net>,
        Anitha Chrisanthus <anitha.chrisanthus@intel.com>,
        Edmund Dea <edmund.j.dea@intel.com>,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Vinod Polimera <quic_vpolimer@quicinc.com>,
        Jiasheng Jiang <jiasheng@iscas.ac.cn>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Jessica Zhang <quic_jesszhan@quicinc.com>,
        Liu Shixin <liushixin2@huawei.com>,
        Marek Vasut <marex@denx.de>, Ben Skeggs <bskeggs@redhat.com>,
        Karol Herbst <kherbst@redhat.com>,
        Lyude Paul <lyude@redhat.com>,
        Tomi Valkeinen <tomba@kernel.org>,
        Emma Anholt <emma@anholt.net>,
        Gerd Hoffmann <kraxel@redhat.com>,
        Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>,
        Tomi Valkeinen <tomi.valkeinen+renesas@ideasonboard.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Sandy Huang <hjc@rock-chips.com>,
        =?UTF-8?Q?Heiko_St=c3=bcbner?= <heiko@sntech.de>,
        Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        Alain Volmat <alain.volmat@foss.st.com>,
        Yannick Fertre <yannick.fertre@foss.st.com>,
        Raphael Gallais-Pou <raphael.gallais-pou@foss.st.com>,
        Philippe Cornu <philippe.cornu@foss.st.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Mikko Perttunen <mperttunen@nvidia.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Jyri Sarha <jyri.sarha@iki.fi>,
        David Lechner <david@lechnology.com>,
        Kamlesh Gurudasani <kamlesh.gurudasani@gmail.com>,
        Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>,
        Melissa Wen <melissa.srw@gmail.com>,
        Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>,
        Michal Simek <michal.simek@amd.com>,
        Haneen Mohammed <hamohammed.sa@gmail.com>,
        linux-hyperv@vger.kernel.org, linux-aspeed@lists.ozlabs.org,
        nouveau@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        virtualization@lists.linux-foundation.org,
        Yongqin Liu <yongqin.liu@linaro.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        Fabio Estevam <festevam@gmail.com>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Jerome Brunet <jbrunet@baylibre.com>,
        linux-samsung-soc@vger.kernel.org, amd-gfx@lists.freedesktop.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-rockchip@lists.infradead.org,
        Xinwei Kong <kong.kongxinwei@hisilicon.com>,
        VMware Graphics Reviewers 
        <linux-graphics-maintainer@vmware.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        spice-devel@lists.freedesktop.org, linux-sunxi@lists.linux.dev,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        linux-arm-msm@vger.kernel.org, intel-gfx@lists.freedesktop.org,
        linux-mediatek@lists.infradead.org, xen-devel@lists.xenproject.org,
        linux-tegra@vger.kernel.org, linux-amlogic@lists.infradead.org,
        Gurchetan Singh <gurchetansingh@chromium.org>,
        Sean Paul <sean@poorly.run>,
        linux-arm-kernel@lists.infradead.org,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Andrew Jeffery <andrew@aj.id.au>, linux-mips@vger.kernel.org,
        Chia-I Wu <olvaffe@gmail.com>,
        linux-renesas-soc@vger.kernel.org, kernel@pengutronix.de,
        John Stultz <jstultz@google.com>,
        freedreno@lists.freedesktop.org,
        Lucas Stach <l.stach@pengutronix.de>
References: <20230712094702.1770121-1-u.kleine-koenig@pengutronix.de>
 <87fs5tgpvv.fsf@intel.com>
 <CAOw6vbLO_UaXDbTCtAQJgthXOUMPqEV+c2MQhP-1DuK44OhGxw@mail.gmail.com>
From:   Krzysztof Kozlowski <krzk@kernel.org>
In-Reply-To: <CAOw6vbLO_UaXDbTCtAQJgthXOUMPqEV+c2MQhP-1DuK44OhGxw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On 12/07/2023 20:31, Sean Paul wrote:
>>>     216 struct drm_device *ddev
>>>     234 struct drm_device *drm_dev
>>>     611 struct drm_device *drm
>>>    4190 struct drm_device *dev
>>>
>>> This series starts with renaming struct drm_crtc::dev to drm_dev. If
>>> it's not only me and others like the result of this effort it should be
>>> followed up by adapting the other structs and the individual usages in
>>> the different drivers.
>>
>> I think this is an unnecessary change. In drm, a dev is usually a drm
>> device, i.e. struct drm_device *. As shown by the numbers above.
>>
> 
> I'd really prefer this patch (series or single) is not accepted. This
> will cause problems for everyone cherry-picking patches to a
> downstream kernel (LTS or distro tree). I usually wouldn't expect
> sympathy here, but the questionable benefit does not outweigh the cost
> IM[biased]O.

You know, every code cleanup and style adjustment is interfering with
backporting. The only argument for a fast-pacing kernel should be
whether the developers of this code find it more readable with such cleanup.

Best regards,
Krzysztof

